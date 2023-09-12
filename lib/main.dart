// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/firebase_options.dart';
import 'package:gifthub/layer/data/source/local/tokens.cache.dart';
import 'package:gifthub/layer/data/source/local/tokens.storage.dart';
import 'package:gifthub/layer/presentation/app.dart';

late TokensCache tokensCache; // TODO: Remove this.
late TokensStorage tokensStorage; // TODO: Remove this.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tokensCache = TokensCache();
  tokensStorage = TokensStorage();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
