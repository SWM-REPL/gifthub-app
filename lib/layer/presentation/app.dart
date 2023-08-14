// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.widget.dart';
import 'package:gifthub/theme/appbar.theme.dart';
import 'package:gifthub/theme/button.theme.dart';
import 'package:gifthub/theme/color.theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        colorScheme: const GifthubColorScheme(),
        appBarTheme: const GifthubAppBarTheme(),
        textTheme: GoogleFonts.notoSansGothicTextTheme(),
        outlinedButtonTheme: const GifthubOutlinedButtonThemeData(),
        elevatedButtonTheme: const GifthubElevatedButtonThemeData(),
      ),
      home: const VoucherList(),
    );
  }
}
