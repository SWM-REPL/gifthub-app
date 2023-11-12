// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';

class LabeledField extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          const SizedBox(width: GiftHubConstants.padding),
          Text(
            labelText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: GiftHubConstants.padding),
          Expanded(
            child: child,
          ),
          if (showForwardIcon)
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
          const SizedBox(width: GiftHubConstants.padding),
        ],
      ),
    );
  }
}
