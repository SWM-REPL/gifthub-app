// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/color.theme.dart';

class GiftHubAppBarTheme extends AppBarTheme {
  const GiftHubAppBarTheme({
    super.elevation = 0,
    super.foregroundColor = GiftHubColors.onSurface,
    super.backgroundColor = GiftHubColors.surface,
    super.iconTheme = const IconThemeData(
      color: Colors.black,
    ),
    super.titleTextStyle = const TextStyle(
      fontFamily: 'Pretendard',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
  });
}
