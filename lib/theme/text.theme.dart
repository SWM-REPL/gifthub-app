// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class GifthubTextTheme {
  static TextTheme get theme {
    return TextTheme(
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
        fontWeight: FontWeight.w500,
      ),
      titleMedium: _customTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: _customTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelLarge: _customTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: _customTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: _customTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      bodyLarge: _customTextStyle(
        fontSize: 14,
        letterSpacing: 0.15,
      ),
      bodyMedium: _customTextStyle(
        fontSize: 12,
        letterSpacing: 0.25,
      ),
      bodySmall: _customTextStyle(
        fontSize: 11,
        letterSpacing: 0.4,
      ),
    );
  }

  static TextStyle _customTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 0,
  }) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
    );
  }
}

// Usage:
final themeData = ThemeData(
  textTheme: GifthubTextTheme.theme,
);
