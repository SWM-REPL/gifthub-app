// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNotificationCommand extends Command {
  final int id;
  final NotificationRepository _notificationRepository;

  FetchNotificationCommand(
    this.id, {
    required NotificationRepository notificationRepository,
    required final FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('fetch_notification', analytics);

  Future<Notification> call() async {
    try {
      final notification = await _notificationRepository.getNotification(id);
      logSuccess({
        'notification_type': notification.type,
      });
      return notification;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
