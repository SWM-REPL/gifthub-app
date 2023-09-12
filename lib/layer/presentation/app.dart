// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/provider/entity/notices.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher_ids.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/register_voucher.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/update_fcm_token.provider.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.widget.dart';
import 'package:gifthub/theme/appbar.theme.dart';
import 'package:gifthub/theme/button.theme.dart';
import 'package:gifthub/theme/color.theme.dart';
import 'package:gifthub/theme/text.theme.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  late StreamSubscription _mediaStreamSubscription;
  late StreamSubscription _textStreamSubscription;

  List<SharedMediaFile> _sharedFiles = [];
  String _sharedText = '';

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      final updateFcmToken = ref.watch(updateFcmTokenProvider);
      updateFcmToken(fcmToken);
    }).onError((error) {
      throw error;
    });

    FirebaseMessaging.onMessage.listen((message) async {
      final title = message.notification?.title;
      final body = message.notification?.body;

      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!, style: Theme.of(context).textTheme.bodyLarge),
              Text(body!, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      );
      ref.invalidate(noticesProvider);
    });

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
      _afterBuild();
    }
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        colorScheme: const GifthubColorScheme(),
        appBarTheme: const GifthubAppBarTheme(),
        textTheme: GifthubTextTheme.theme,
        outlinedButtonTheme: const GifthubOutlinedButtonThemeData(),
        elevatedButtonTheme: const GifthubElevatedButtonThemeData(),
      ),
      home: VoucherList(),
    );
  }

  Future<void> _afterBuild() async {
    await Future.delayed(Duration.zero);
    await _processSharedIntents();
  }

  Future<void> _processSharedIntents() async {
    final registerVoucher = ref.watch(registerVoucherProvider);
    await registerVoucher(imagePath: _sharedFiles.first.path);
    ref.invalidate(voucherIdsProvider);
    setState(() {
      _sharedFiles = [];
      _sharedText = '';
    });
  }
}
