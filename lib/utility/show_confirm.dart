// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';

void showConfirm({
  Widget? title,
  Widget? content,
  void Function()? onConfirmPressed,
  void Function()? onCanclePressed,
}) {
  final context = navigatorKey.currentState?.overlay?.context;
  if (context == null) {
    return;
  }

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
            if (onCanclePressed != null) {
              onCanclePressed();
            }
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Confirm');
            if (onConfirmPressed != null) {
              onConfirmPressed();
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
