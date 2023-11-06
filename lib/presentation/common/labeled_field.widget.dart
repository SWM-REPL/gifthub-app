// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final Widget child;
  final void Function(PointerDownEvent)? onTap;
  final String labelText;
  final bool showForwardIcon;

  const LabeledField({
    super.key,
    required this.child,
    required this.labelText,
    this.showForwardIcon = true,
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
          if (showForwardIcon)
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
