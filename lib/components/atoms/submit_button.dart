import 'package:flutter/material.dart';

class SubmitButton extends ElevatedButton {
  SubmitButton({
    required final Key key,
    required final String text,
    required final void Function() onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 48),
            ),
          ),
          child: Text(text),
        );
}
