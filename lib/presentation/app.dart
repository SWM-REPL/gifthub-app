// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// 🌎 Project imports:
import 'package:gifthub/global_keys.dart';
import 'package:gifthub/presentation/exception.boundary.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.view.dart';
import 'package:gifthub/theme/appbar.theme.dart';
import 'package:gifthub/theme/button.theme.dart';
import 'package:gifthub/theme/card.theme.dart';
import 'package:gifthub/theme/color.theme.dart';
import 'package:gifthub/theme/divider.theme.dart';
import 'package:gifthub/theme/text.theme.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

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

    _initializeFirebaseMessaging();

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
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: GiftHubColors.background,
        appBarTheme: const GiftHubAppBarTheme(),
        outlinedButtonTheme: const GiftHubOutlinedButtonThemeData(),
        elevatedButtonTheme: const GiftHubElevatedButtonThemeData(),
        textButtonTheme: const GiftHubTextButtonThemeData(),
        cardTheme: const GiftHubCardTheme(),
        colorScheme: const GiftHubColorScheme(),
        dividerTheme: GiftHubDividerTheme.data,
        textTheme: GiftHubTextTheme.theme,
      ),
      home: const ExceptionBoundary(
        child: VoucherListView(),
      ),
    );
  }

  void _initializeFirebaseMessaging() {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      ref.watch(appUserProvider.notifier).subscribeNotification(fcmToken);
    }).onError((error) {
      throw error;
    });

    FirebaseMessaging.onMessage.listen((message) async {
      final title = message.notification?.title;
      final body = message.notification?.body;

      ref.invalidate(notificationsProvider);
      showSnackBar(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!, style: Theme.of(context).textTheme.bodyLarge),
            Text(body!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      );
    });
  }

  Future<void> _afterBuild() async {
    await Future.delayed(
      Duration.zero,
      _processSharedIntents,
    );
  }

  Future<void> _processSharedIntents() async {
    final createVoucherByImageCommand =
        ref.watch(createVoucherByImageCommandProvider);
    await Future.wait(_sharedFiles.map(
      (f) => createVoucherByImageCommand(f.path),
    ));
    ref.invalidate(voucherIdsProvider);
    setState(() {
      _sharedFiles = [];
      _sharedText = '';
    });
  }
}
