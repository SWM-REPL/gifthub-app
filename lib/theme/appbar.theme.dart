// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/color.theme.dart';

class GifthubAppBarTheme extends AppBarTheme {
  const GifthubAppBarTheme({
    super.backgroundColor = surface,
    super.elevation = 0,
    super.iconTheme = const IconThemeData(
      color: Color(0xFF838A9A),
    ),
  });
}
