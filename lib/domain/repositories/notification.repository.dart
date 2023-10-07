// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications();

  Future<Notification> getNotification(int id);

  Future<void> subscribeNotification(String fcmToken);
}
