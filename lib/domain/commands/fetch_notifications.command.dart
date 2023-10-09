// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNotificationsCommand {
  static const name = 'fetch_notifications';

  final NotificationRepository _notificationRepository;
  final FirebaseAnalytics _analytics;

  FetchNotificationsCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        _analytics = analytics;

  Future<List<Notification>> call() async {
    try {
      final notifications = await _notificationRepository.getNotifications();
      return await Future.wait(
        notifications.map((n) async {
          final notification =
              await _notificationRepository.getNotification(n.id);
          _analytics.logEvent(
            name: FetchNotificationsCommand.name,
            parameters: {
              'success': true,
              'notification_type': notification.type,
            },
          );
          return notification;
        }),
      );
    } catch (e) {
      _analytics.logEvent(
        name: FetchNotificationsCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
