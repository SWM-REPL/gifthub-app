// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNewNotificationCountCommand extends Command {
  final NotificationRepository _notificationRepository;

  FetchNewNotificationCountCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('fetch_new_notification_count', analytics);

  Future<int> call() async {
    try {
      final notifications = await _notificationRepository.getNotifications();
      final newNotifications =
          notifications.where((notification) => notification.checkedAt == null);
      logSuccess({'count': newNotifications.length});
      return newNotifications.length;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
