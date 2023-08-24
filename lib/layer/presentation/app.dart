// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher_ids.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/register_voucher.provider.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.widget.dart';
import 'package:gifthub/theme/appbar.theme.dart';
import 'package:gifthub/theme/button.theme.dart';
import 'package:gifthub/theme/color.theme.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
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
    if (_sharedFiles.isNotEmpty || _sharedText.isNotEmpty) {
      Future.sync(() async {
        final registerVoucher = ref.watch(registerVoucherProvider);
        await registerVoucher(imagePath: _sharedFiles.first.path);
        ref.invalidate(voucherIdsProvider);
        setState(() {
          _sharedFiles = [];
          _sharedText = '';
        });
      });
    }

    return MaterialApp(
      themeMode: ThemeMode.light,
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
