// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/color.theme.dart';

class GiftHubCardTheme extends CardTheme {
  const GiftHubCardTheme({
    super.elevation = 0,
    super.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    super.color = GiftHubColors.surface,
  });
}
