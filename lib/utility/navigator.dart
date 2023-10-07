// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';

Widget navigate(
  Widget widget, {
  bool clearStack = false,
}) {
  final navigator = navigatorKey.currentState;
  if (navigator == null) {
    return const SizedBox.shrink();
  }

  Future.microtask(() {
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => widget,
      ),
      (route) => !clearStack,
    );
  });
  return const SizedBox.shrink();
}

Widget navigateBack({
  int count = 1,
}) {
  final navigator = navigatorKey.currentState;
  if (navigator == null) {
    return const SizedBox.shrink();
  }

  Future.microtask(() {
    navigator.popUntil((route) => route.isFirst || count-- == 0);
  });
  return const SizedBox.shrink();
}

void showModal(
  Widget widget, {
  Color? backgroundColor,
}) {
  final navigator = navigatorKey.currentState;
  if (navigator == null) {
    return;
  }

  Future.microtask(
    () => navigator.push(
      ModalBottomSheetRoute(
        builder: (context) => widget,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        backgroundColor: backgroundColor,
      ),
    ),
  );
}
