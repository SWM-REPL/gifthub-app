// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class DeleteNotificationCommand extends Command {
  final NotificationRepository _notificationRepository;

  DeleteNotificationCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('delete_notification', analytics);

  Future<void> call(notificationId) async {
    try {
      await _notificationRepository.deleteNotification(notificationId);
      logSuccess({'notificationId': notificationId});
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
