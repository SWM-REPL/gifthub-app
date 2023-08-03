import 'package:flutter/material.dart';
import 'package:gifthub/apis/url.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class SigninWithKakao extends StatelessWidget {
  const SigninWithKakao({super.key});

  void onPressed() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await AuthCodeClient.instance.authorizeWithTalk(
          redirectUri: ApiUrl.kakaoRedirectUri,
        );
      } else {
        await AuthCodeClient.instance.authorize(
          redirectUri: ApiUrl.kakaoRedirectUri,
        );
      }
    } catch (e) {
      print('Failed to login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFFFFE500),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 48),
        ),
        shadowColor: MaterialStateProperty.all(
          Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.apple_rounded,
            color: Colors.black,
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                '카카오로 로그인하기',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
