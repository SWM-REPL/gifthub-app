import 'package:flutter/material.dart';

import 'package:gifthub/components/atoms/submit_button.dart';
import 'package:gifthub/components/molecules/signin_oauthbox.dart';
import 'package:gifthub/components/molecules/signin_toolbox.dart';

class SigninTemplate extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final void Function() onSigninPressed;

  final _formKey = GlobalKey<FormState>();

  SigninTemplate({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onSigninPressed,
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
                '로그인',
                style: Theme.of(context).textTheme.displaySmall,
              )
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
                SubmitButton(
                  key: _formKey,
                  text: '로그인',
                  onPressed: onSigninPressed,
                ),
                const SizedBox(height: 16),
                const SigninToolbox(),
                const SigninOauthBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
