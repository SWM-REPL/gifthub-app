import 'package:flutter/material.dart';

class SignupTemplate extends StatelessWidget {
  final BuildContext context;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordCheckController;
  final TextEditingController nicknameController;
  final void Function() onSignupPressed;

  const SignupTemplate({
    super.key,
    required this.context,
    required this.usernameController,
    required this.passwordController,
    required this.passwordCheckController,
    required this.nicknameController,
    required this.onSignupPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 32),
              Icon(
                Icons.wallet_rounded,
                size: 64,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                '회원가입',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordCheckController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                    labelText: '닉네임',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onSignupPressed,
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
      ],
    );
  }
}
