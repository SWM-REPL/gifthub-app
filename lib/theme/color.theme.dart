// 🐦 Flutter imports:
import 'package:flutter/material.dart';

const primary = Color(0xFFF73653);
const onPrimary = Color(0xFFFFFFFF);
const secondary = Color(0xFF838A9A);
const onSecondary = Color(0xFFFFFFFF);
const error = Color(0xFFF73653);
const onError = Color(0xFFFFFFFF);
const background = Color(0xFFECEDEE);
const onBackground = Color(0xFF000000);
const surface = Color(0xFFFFFFFF);
const onSurface = Color(0xFF000000);

// class ColorScheme {
//   ColorScheme({
//     required Brightness brightness,
//     required Color primary,
//     required Color onPrimary,
//     Color? primaryContainer,
//     Color? onPrimaryContainer,
//     required Color secondary,
//     required Color onSecondary,
//     Color? secondaryContainer,
//     Color? onSecondaryContainer,
//     Color? tertiary,
//     Color? onTertiary,
//     Color? tertiaryContainer,
//     Color? onTertiaryContainer,
//     required Color error,
//     required Color onError,
//     Color? errorContainer,
//     Color? onErrorContainer,
//     required Color background,
//     required Color onBackground,
//     required Color surface,
//     required Color onSurface,
//     Color? surfaceVariant,
//     Color? onSurfaceVariant,
//     Color? outline,
//     Color? outlineVariant,
//     Color? shadow,
//     Color? scrim,
//     Color? inverseSurface,
//     Color? onInverseSurface,
//     Color? inversePrimary,
//     Color? surfaceTint,
//   });
// }

class GifthubColorScheme extends ColorScheme {
  const GifthubColorScheme({
    super.brightness = Brightness.light,
    super.primary = primary,
    super.onPrimary = onPrimary,
    super.secondary = secondary,
    super.onSecondary = onSecondary,
    super.error = error,
    super.onError = onError,
    super.background = background,
    super.onBackground = onBackground,
    super.surface = surface,
    super.onSurface = onSurface,
  });
}
