// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/color.theme.dart';

class GiftHubTextTheme {
  static TextTheme get theme => TextTheme(
        displayLarge: _customTextStyle(
          fontSize: 57,
        ),
        displayMedium: _customTextStyle(
          fontSize: 45,
        ),
        displaySmall: _customTextStyle(
          fontSize: 36,
        ),
        headlineLarge: _customTextStyle(
          fontSize: 32,
        ),
        headlineMedium: _customTextStyle(
          fontSize: 28,
        ),
        headlineSmall: _customTextStyle(
          fontSize: 24,
        ),
        titleLarge: _customTextStyle(
          fontSize: 22,
        ),
        titleMedium: _customTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleSmall: _customTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
        ),
        labelLarge: _customTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        labelMedium: _customTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        labelSmall: _customTextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyLarge: _customTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        bodyMedium: _customTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        bodySmall: _customTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: GiftHubColors.secondary,
        ),
      );

  static TextStyle _customTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
    Color color = GiftHubColors.onSurface,
  }) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      color: color,
    );
  }
}

// Usage:
final themeData = ThemeData(
  textTheme: GiftHubTextTheme.theme,
);
