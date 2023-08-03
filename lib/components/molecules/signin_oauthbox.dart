import 'package:flutter/material.dart';
import 'package:gifthub/components/atoms/signin_with_kakao.dart';
import 'package:gifthub/components/atoms/signin_with_naver.dart';

class SigninOauthBox extends StatelessWidget {
  const SigninOauthBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SigninWithKakao(),
        SizedBox(height: 16),
        SigninWithNaver(),
      ],
    );
  }
}
