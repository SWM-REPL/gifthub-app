// 🐦 Flutter imports:
import 'package:flutter/material.dart';

void navigate({
  required BuildContext context,
  required Widget widget,
  RoutePredicate? predicate,
}) {
  Future.microtask(() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      predicate ?? (route) => true,
    );
  });
}
