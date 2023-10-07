// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';

void showSnackBar(Widget content) {
  final scaffoldMessenger = scaffoldMessengerKey.currentState;
  if (scaffoldMessenger == null) {
    return;
  }

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: content,
    ),
  );
}
