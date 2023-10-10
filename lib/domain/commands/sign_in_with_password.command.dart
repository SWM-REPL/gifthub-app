// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class SignInWithPasswordCommand extends Command {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;
  final NotificationRepository _notificationRepository;

  SignInWithPasswordCommand({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        _notificationRepository = notificationRepository,
        super('sign_in_with_password', analytics);

  Future<void> call(
    String username,
    String password,
  ) async {
    try {
      await _authRepository.signInWithPassword(
        username: username,
        password: password,
      );
      final fcmToken = await _tokenRepository.getFCMToken();
      if (fcmToken != null) {
        await _notificationRepository.subscribeNotification(fcmToken);
      }
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
