// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNotificationsCommand extends Command {
  final NotificationRepository _notificationRepository;

  FetchNotificationsCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('fetch_notifications', analytics);

  Future<List<Notification>> call() async {
    try {
      final notifications = await _notificationRepository.getNotifications();
      logSuccess({
        'notification_count': notifications.length.toString(),
      });
      return notifications;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
