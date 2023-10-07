// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class GiftHubColors {
  static const primary = Color(0xFFF73653);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF838A9A);
  static const onSecondary = Color(0xFFFFFFFF);
  static const tertiary = Color(0xFFF3F3F5);
  static const onTertiary = Color(0xFF000000);
  static const secondaryContainer = Color(0xFFE3E3E5);
  static const error = Color(0xFFF73653);
  static const onError = Color(0xFFFFFFFF);
  static const background = Color(0xFFECEDEE);
  static const onBackground = Color(0xFF000000);
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF000000);
}

class GiftHubColorScheme extends ColorScheme {
  const GiftHubColorScheme({
    super.brightness = Brightness.light,
    super.primary = GiftHubColors.primary,
    super.onPrimary = GiftHubColors.onPrimary,
    super.secondary = GiftHubColors.secondary,
    super.onSecondary = GiftHubColors.onSecondary,
    super.tertiary = GiftHubColors.tertiary,
    super.onTertiary = GiftHubColors.onTertiary,
    super.secondaryContainer = GiftHubColors.secondaryContainer,
    super.error = GiftHubColors.error,
    super.onError = GiftHubColors.onError,
    super.background = GiftHubColors.background,
    super.onBackground = GiftHubColors.onBackground,
    super.surface = GiftHubColors.surface,
    super.onSurface = GiftHubColors.onSurface,
  });
}
