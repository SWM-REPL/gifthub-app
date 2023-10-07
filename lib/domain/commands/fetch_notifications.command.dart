// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class FetchNotificationsCommand {
  final NotificationRepository _notificationRepository;

  FetchNotificationsCommand({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<List<Notification>> call() async {
    final notifications = await _notificationRepository.getNotifications();
    return await Future.wait(
      notifications.map(
        (notification) async =>
            await _notificationRepository.getNotification(notification.id),
      ),
    );
  }
}
