// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness brightness) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: const Color(0xFFF73653),
        ),
        textTheme: GoogleFonts.notoSansGothicTextTheme(),
      );
    }

    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: const VoucherList(),
    );
  }
}
