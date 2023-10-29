// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';

void showSnackBar({
  Widget? content,
  String? text,
}) {
  final scaffoldMessenger = scaffoldMessengerKey.currentState;
  if (scaffoldMessenger == null) {
    return;
  }

  scaffoldMessenger.hideCurrentSnackBar();
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: content ??
          (text != null ? Text(text) : const Text('알 수 없는 오류가 생겼어요!')),
    ),
  );
}
