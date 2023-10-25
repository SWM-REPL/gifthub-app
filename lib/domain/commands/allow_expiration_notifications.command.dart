// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class AllowExpirationNotificationsCommand extends Command {
  final NotificationRepository _notificationRepository;

  AllowExpirationNotificationsCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('allow_expiration_notifications', analytics);

  Future<void> call() async {
    try {
      await _notificationRepository.allowExpirationNotifications();
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
