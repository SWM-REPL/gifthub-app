// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/labeled_field.widget.dart';

class LabeledTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool enabled;
  final bool obsecureText;
  final bool showForwardIcon;
  final TextInputType keyboardType;
  final void Function(PointerDownEvent)? onTap;

  const LabeledTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.enabled = true,
    this.obsecureText = false,
    this.showForwardIcon = true,
    this.keyboardType = TextInputType.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      showForwardIcon: showForwardIcon,
      labelText: labelText,
      onTap: onTap,
      child: TextFormField(
        textAlign: TextAlign.right,
        enabled: enabled,
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
        keyboardType: keyboardType,
        obscureText: obsecureText,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
