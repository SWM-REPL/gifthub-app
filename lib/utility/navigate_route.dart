// 🐦 Flutter imports:
import 'package:flutter/material.dart';

void navigate({
  required BuildContext context,
  required Widget widget,
  RoutePredicate? predicate,
  bool bottomModal = false,
}) {
  Future.microtask(() {
    if (bottomModal) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => widget,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        predicate ?? (route) => true,
      );
    }
  });
}
