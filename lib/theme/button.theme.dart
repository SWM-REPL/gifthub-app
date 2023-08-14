// 🐦 Flutter imports:
import 'package:flutter/material.dart';

const _buttonShape = MaterialStatePropertyAll(
  RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
);

class GifthubElevatedButtonThemeData extends ElevatedButtonThemeData {
  const GifthubElevatedButtonThemeData({
    super.style = const ButtonStyle(
      textStyle: MaterialStatePropertyAll(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: MaterialStatePropertyAll(0),
      shape: _buttonShape,
    ),
  });
}

class GifthubOutlinedButtonThemeData extends OutlinedButtonThemeData {
  const GifthubOutlinedButtonThemeData({
    super.style = const ButtonStyle(
      padding: MaterialStatePropertyAll(
        EdgeInsets.all(0),
      ),
      shape: _buttonShape,
    ),
  });
}
