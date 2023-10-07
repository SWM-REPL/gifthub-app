// 🌎 Project imports:
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNewNotificationCountCommand {
  final NotificationRepository _notificationRepository;

  FetchNewNotificationCountCommand({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<int> call() async {
    final notifications = await _notificationRepository.getNotifications();
    final newNotifications =
        notifications.where((notification) => notification.checkedAt == null);
    return newNotifications.length;
  }
}
