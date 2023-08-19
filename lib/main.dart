// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:gifthub/firebase_options.dart';
import 'package:gifthub/layer/data/source/local/tokens.cache.dart';
import 'package:gifthub/layer/data/source/local/tokens.storage.dart';
import 'package:gifthub/layer/presentation/app.dart';

late SharedPreferences sharedPref;
late TokensCache tokensCache; // TODO: Remove this.
late TokensStorage tokensStorage; // TODO: Remove this.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPref = await SharedPreferences.getInstance();
  tokensCache = TokensCache();
  tokensStorage = TokensStorage();

  // tokensCache.deleteTokens();
  // tokensStorage.deleteTokens();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
