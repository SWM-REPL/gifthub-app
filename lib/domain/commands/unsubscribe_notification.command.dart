// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class UnsubscribeNotificationCommand extends Command {
  final NotificationRepository _notificationRepository;

  UnsubscribeNotificationCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('unsubscribe_notification', analytics);

  Future<void> call() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await _notificationRepository.unsubscribeNotification(fcmToken!);
      logSuccess();
    } catch (error, stackTrace) {
      logFailure(error, stackTrace);
      rethrow;
    }
  }
}
