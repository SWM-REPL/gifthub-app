// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.view.dart';
import 'package:gifthub/utility/navigator.dart';

class SignInWithPasswordView extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  SignInWithPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: appUser.when(
        data: (data) {
          if (data != null) {
            return navigate(const VoucherListView(), clearStack: true);
          } else {
            return _buildSignInForm(context, ref, false);
          }
        },
        loading: () => _buildSignInForm(context, ref, true),
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

  Widget _buildSignInForm(BuildContext context, WidgetRef ref, bool loading) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              validator: _validateUsername,
              decoration: const InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: _validatePassword,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        ref.watch(signInWithPasswordCommandProvider)(
                          usernameController.text,
                          passwordController.text,
                        );
                      }
                    },
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
}
