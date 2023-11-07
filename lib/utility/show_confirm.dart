// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';

Future<bool?> showConfirm({
  Widget? title,
  Widget? content,
  void Function()? onConfirmPressed,
  String confirmText = '확인',
  void Function()? onCanclePressed,
  String cancleText = '취소',
}) async {
  final context = navigatorKey.currentState?.overlay?.context;
  if (context == null) {
    return false;
  }

  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: content,
      actions: [
        if (onCanclePressed != null)
          TextButton(
            onPressed: () {
              onCanclePressed();
              Navigator.of(context).pop(false);
            },
            child: Text(cancleText),
          ),
        if (onConfirmPressed != null)
          TextButton(
            onPressed: () {
              onConfirmPressed();
              Navigator.of(context).pop(true);
            },
            child: Text(confirmText),
          ),
      ],
    ),
  );
}
