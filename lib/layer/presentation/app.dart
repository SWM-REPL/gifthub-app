// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/appbar.theme.dart';
import 'package:gifthub/theme/button.theme.dart';
import 'package:gifthub/theme/color.theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late StreamSubscription _mediaStreamSubscription;
  late StreamSubscription _textStreamSubscription;

  List<SharedMediaFile> _sharedFiles = [];
  String _sharedText = '';

  @override
  void initState() {
    super.initState();

    _mediaStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
      });
    });

    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
      });
    });

    _textStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
      });
    });

    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        _sharedText = value ?? '';
      });
    });
  }

  @override
  void dispose() {
    _mediaStreamSubscription.cancel();
    _textStreamSubscription.cancel();
    super.dispose();
  }

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
      // home: const VoucherList(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text('Shared files:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_sharedFiles.map((f) => f.path).join(',')),
              const SizedBox(height: 100),
              const Text('Shared urls/text:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_sharedText)
            ],
          ),
        ),
      ),
    );
  }
}
