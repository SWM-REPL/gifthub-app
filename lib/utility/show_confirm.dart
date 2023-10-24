// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';

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
        if (onCanclePressed != null)
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              onCanclePressed();
            },
            child: Text(cancleText),
          ),
        if (onConfirmPressed != null)
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Confirm');
              onConfirmPressed();
            },
            child: Text(confirmText),
          ),
      ],
    ),
  );
}
