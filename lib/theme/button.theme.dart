// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/color.theme.dart';

const _buttonShape = MaterialStatePropertyAll(
  RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
);

class GiftHubElevatedButtonThemeData extends ElevatedButtonThemeData {
  const GiftHubElevatedButtonThemeData({
    super.style = const ButtonStyle(
      elevation: MaterialStatePropertyAll(0),
      shape: _buttonShape,
    ),
  });
}

class GiftHubOutlinedButtonThemeData extends OutlinedButtonThemeData {
  const GiftHubOutlinedButtonThemeData({
    super.style = const ButtonStyle(
      padding: MaterialStatePropertyAll(
        EdgeInsets.all(0),
      ),
      shape: _buttonShape,
    ),
  });
}

class GiftHubTextButtonThemeData extends TextButtonThemeData {
  const GiftHubTextButtonThemeData({
    super.style = const ButtonStyle(
      padding: MaterialStatePropertyAll(
        EdgeInsets.all(0),
      ),
      foregroundColor: MaterialStatePropertyAll(
        GiftHubColors.secondary,
      ),
    ),
  });
}
