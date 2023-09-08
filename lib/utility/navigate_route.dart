// 🐦 Flutter imports:
import 'package:flutter/material.dart';

void navigate(
  Widget widget, {
  required BuildContext context,
  RoutePredicate? predicate,
  bool bottomModal = false,
}) {
  Future.microtask(() {
    if (bottomModal) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) => widget,
        backgroundColor: Theme.of(context).colorScheme.surface,
        isScrollControlled: true,
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
