// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNewNotificationCountCommand {
  static const name = 'fetch_new_notification_count';

  final NotificationRepository _notificationRepository;
  final FirebaseAnalytics _analytics;

  FetchNewNotificationCountCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        _analytics = analytics;

  Future<int> call() async {
    try {
      final notifications = await _notificationRepository.getNotifications();
      final newNotifications =
          notifications.where((notification) => notification.checkedAt == null);
      _analytics.logEvent(
        name: FetchNewNotificationCountCommand.name,
        parameters: {
          'success': true,
          'count': newNotifications.length,
        },
      );
      return newNotifications.length;
    } catch (e) {
      _analytics.logEvent(
        name: FetchNewNotificationCountCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
