// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final Widget child;
  final void Function(PointerDownEvent)? onTap;
  final String labelText;

  const LabeledField({
    super.key,
    required this.labelText,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            labelText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: child,
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: 16,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
