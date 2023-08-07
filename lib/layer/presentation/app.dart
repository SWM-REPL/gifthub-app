import 'package:flutter/material.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.page.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness brightness) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: const Color.fromARGB(255, 227, 73, 88),
        ),
        textTheme: GoogleFonts.notoSansGothicTextTheme(),
      );
    }

    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: const VoucherListPage(),
    );
  }
}
