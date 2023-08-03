import 'package:flutter/material.dart';

import 'package:gifthub/screens/auth/signup.screen.dart';
import 'package:gifthub/utils/screen.dart';

class SigninToolbox extends StatelessWidget {
  const SigninToolbox({super.key});

  void onForgotUsernamePressed() {}

  void onForgotPasswordPressed() {}

  @override
  Widget build(BuildContext context) {
    final linkStyle = Theme.of(context).textTheme.bodyMedium;
    final dividerStyle = Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onForgotUsernamePressed,
          child: Text(
            '아이디 찾기',
            style: linkStyle,
          ),
        ),
        Text(
          ' | ',
          style: dividerStyle,
        ),
        TextButton(
          onPressed: onForgotPasswordPressed,
          child: Text(
            '비밀번호 찾기',
            style: linkStyle,
          ),
        ),
        Text(
          ' | ',
          style: dividerStyle,
        ),
        TextButton(
          onPressed: () => openScreen(context, SignupScreen()),
          child: Text(
            '회원가입',
            style: linkStyle,
          ),
        ),
      ],
    );
  }
}
