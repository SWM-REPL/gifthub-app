// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final void Function(PointerDownEvent)? onTap;

  const LabeledTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: onTap,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Flexible(
            flex: 15,
            child: TextFormField(
              textAlign: TextAlign.right,
              enabled: enabled,
              controller: controller,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Flexible(
            flex: 0,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
