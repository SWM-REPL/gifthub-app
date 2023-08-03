import 'package:flutter/material.dart';

class SigninWithNaver extends StatelessWidget {
  const SigninWithNaver({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFF03C75A),
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
            color: Colors.white,
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                '네이버로 로그인하기',
                style: TextStyle(
                  color: Colors.white,
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
