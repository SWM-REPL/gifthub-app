// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class RegisterDeviceCommand extends Command {
  final NotificationRepository _notificationRepository;

  RegisterDeviceCommand({
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _notificationRepository = notificationRepository,
        super('subscribe_notification', analytics);

  Future<void> call() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await _notificationRepository.subscribeNotification(fcmToken!);
      logSuccess();
    } catch (error, stackTrace) {
      logFailure(error, stackTrace);
      rethrow;
    }
  }
}
