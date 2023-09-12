// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class SignUpContent extends ConsumerStatefulWidget {
  const SignUpContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpContentState();
}

class _SignUpContentState extends ConsumerState<SignUpContent> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();

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
                '회원가입',
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
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
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: '비밀번호 확인',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        labelText: '닉네임',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onSignUpPressed(context),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 48),
                        ),
                      ),
                      child: const Text('회원가입'),
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

  void _onSignUpPressed(BuildContext context) async {
    if (!_verifyInputs()) {
      return;
    }

    await ref.read(appUserProvider.notifier).signUp(
          _usernameController.text,
          _passwordController.text,
          _nicknameController.text,
        );
  }

  bool _verifyInputs() {
    if (_usernameController.text.isEmpty) {
      showSnackBar(context, '아이디를 입력해주세요.');
      return false;
    }
    if (_passwordController.text.isEmpty) {
      showSnackBar(context, '비밀번호를 입력해주세요.');
      return false;
    }
    if (_confirmPasswordController.text.isEmpty) {
      showSnackBar(context, '비밀번호 확인을 입력해주세요.');
      return false;
    }
    if (_nicknameController.text.isEmpty) {
      showSnackBar(context, '닉네임을 입력해주세요.');
      return false;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      showSnackBar(context, '비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      return false;
    }
    return true;
  }
}
