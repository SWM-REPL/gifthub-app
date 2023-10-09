// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class SignOutCommand extends Command {
  final AuthRepository _authRepository;
  final NotificationRepository _notificationRepository;

  SignOutCommand({
    required AuthRepository authRepository,
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
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
    final deviceToken = await _notificationRepository.getDeviceToken();
    if (deviceToken == null) {
      throw Exception('deviceToken is null');
    }
    await _notificationRepository.deleteDeviceToken();
    await _authRepository.signOut(deviceToken: deviceToken);
  }
}
