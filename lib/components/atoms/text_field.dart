import 'package:flutter/material.dart' as material;

class TextFormField extends material.TextFormField {
  TextFormField({
    required final material.Key key,
    required final material.TextEditingController controller,
    required final String labelText,
    required final material.FormFieldValidator<String> validator,
    final obscureText = false,
  }) : super(
          key: key,
          controller: controller,
          decoration: material.InputDecoration(
            labelText: labelText,
            border: const material.OutlineInputBorder(),
          ),
          validator: validator,
          obscureText: obscureText,
        );
}
