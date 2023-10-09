// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

abstract class Command<T> {
  final String name;
  final FirebaseAnalytics _analytics;

  Command(
    this.name,
    FirebaseAnalytics analytics,
  ) : _analytics = analytics;

  void logSuccess([final Map<String, Object>? parameters]) {
    _analytics.logEvent(
      name: name,
      parameters: {
        'success': true.toString(),
        ...?parameters,
      },
    );
  }

  void logFailure(Object error, StackTrace stacktrace) {
    _analytics.logEvent(
      name: name,
      parameters: {
        'success': false.toString(),
        'error': error.toString(),
        'stacktrace': stacktrace.toString(),
      },
    );
  }
}
