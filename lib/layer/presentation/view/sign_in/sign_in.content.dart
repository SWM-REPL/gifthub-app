// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/view/sign_up/sign_up.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class SignInContent extends ConsumerStatefulWidget {
  const SignInContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInContentState();
}

class _SignInContentState extends ConsumerState<SignInContent> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 32),
              Text(
                '로그인',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: MediaQuery.of(context).padding.add(
                    const EdgeInsets.symmetric(horizontal: 20),
                  ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: '아이디',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onSignInPressed(context),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 48),
                        ),
                      ),
                      child: const Text('로그인'),
                    ),
                    TextButton(
                      onPressed: () => navigate(
                        const SignUpPage(),
                        context: context,
                      ),
                      child: Text(
                        '회원이 아니라면 회원가입 하러가기',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onSignInPressed(BuildContext context) async {
    if (!_validateInput()) {
      return;
    }

    await ref.read(appUserProvider.notifier).signIn(
          _usernameController.text,
          _passwordController.text,
        );
  }

  bool _validateInput() {
    if (_usernameController.text.isEmpty) {
      showSnackBar(context, '아이디를 입력해주세요.');
      return false;
    }
    if (_passwordController.text.isEmpty) {
      showSnackBar(context, '비밀번호를 입력해주세요.');
      return false;
    }
    return true;
  }
}
