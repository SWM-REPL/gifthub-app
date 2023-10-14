// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.view.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class SignInWithPasswordView extends ConsumerStatefulWidget {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  SignInWithPasswordView({super.key});

  @override
  ConsumerState<SignInWithPasswordView> createState() =>
      _SignInWithPasswordViewState();
}

class _SignInWithPasswordViewState
    extends ConsumerState<SignInWithPasswordView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(appUserProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: appUser.when(
        data: (data) {
          if (data != null) {
            return navigate(const VoucherListView(), clearStack: true);
          } else {
            return _buildSignInForm(context, false);
          }
        },
        loading: () => _buildSignInForm(context, true),
        error: (error, stackTrace) => throw error,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text('아이디로 계속하기'),
    );
  }

  Widget _buildSignInForm(BuildContext context, bool loading) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: widget.usernameController,
              validator: _validateUsername,
              decoration: const InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: widget.passwordController,
              validator: _validatePassword,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSignIn(
                () async => await ref.watch(signInWithPasswordCommandProvider)(
                  widget.usernameController.text,
                  widget.passwordController.text,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateUsername(String? username) {
    if (username?.isEmpty ?? false) {
      return '아이디를 입력해주세요.';
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password?.isEmpty ?? false) {
      return '비밀번호를 입력해주세요.';
    }
    return null;
  }

  void Function()? _handleSignIn(Future<AuthToken> Function() signIn) {
    return isLoading
        ? null
        : () async {
            try {
              if (widget.formKey.currentState!.validate()) {
                final authToken = await signIn();
                ref.watch(authTokenProvider.notifier).state = authToken;
              }
            } catch (error) {
              if (error is SignInException) {
                setState(() => isLoading = false);
                showSnackBar(Text(error.message ?? '로그인에 실패했습니다.'));
              } else {
                rethrow;
              }
            }
          };
  }
}
