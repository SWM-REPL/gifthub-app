// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';
import 'package:gifthub/utility/navigator.dart';

void showConfirm({
  Widget? title,
  Widget? content,
  void Function()? onConfirmPressed,
  String confirmText = '확인',
  void Function()? onCanclePressed,
  String cancleText = '취소',
}) {
  final context = navigatorKey.currentState?.overlay?.context;
  if (context == null) {
    return;
  }

  showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            navigateBack();
            if (onCanclePressed != null) {
              onCanclePressed();
            }
          },
          child: Text(cancleText),
        ),
        TextButton(
          onPressed: () {
            navigateBack();
            if (onConfirmPressed != null) {
              onConfirmPressed();
            }
          },
          child: Text(confirmText),
        ),
      ],
    ),
  );
}
