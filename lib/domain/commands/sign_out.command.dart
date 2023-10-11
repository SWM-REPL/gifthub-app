// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class SignOutCommand extends Command {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;
  final NotificationRepository _notificationRepository;

  SignOutCommand({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        _notificationRepository = notificationRepository,
        super('sign_out', analytics);

  Future<void> call() async {
    try {
      await _signOut();
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }

  Future<void> _signOut() async {
    final fcmToken = await _tokenRepository.getFCMToken();
    if (fcmToken != null) {
      _notificationRepository.unsubscribeNotification(fcmToken);
    }
    await _tokenRepository.deleteAll();
    await _authRepository.signOut();
  }
}