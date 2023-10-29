// 🌎 Project imports:
import 'package:gifthub/data/dto/notification.dto.dart';
import 'package:gifthub/data/sources/notification.api.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApi _notificationApi;

  NotificationRepositoryImpl({
    required NotificationApi notificationApi,
  }) : _notificationApi = notificationApi;

  @override
  Future<List<NotificationDto>> getNotifications() async {
    return await _notificationApi.getNotifications();
  }

  @override
  Future<NotificationDto> getNotification(int id) {
    return _notificationApi.getNotificationById(id);
  }

  @override
  Future<void> deleteNotification(int id) async {
    await _notificationApi.deleteNotification(id);
  }

  @override
  Future<void> allowExpirationNotifications() async {
    await _notificationApi.allowExpirationNotifications();
  }

  @override
  Future<void> disallowExpirationNotifications() async {
    await _notificationApi.disallowExpirationNotifications();
  }
}
