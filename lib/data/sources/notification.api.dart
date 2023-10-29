// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/notification.dto.dart';

class NotificationApi {
  final Dio dio;

  NotificationApi(this.dio);

  Future<List<NotificationDto>> getNotifications() async {
    final response = await dio.get('/notifications');
    final data = response.data as List<dynamic>;
    // ignore: avoid_dynamic_calls
    return data.map((json) => NotificationDto.fromJson(json)).toList();
  }

  Future<NotificationDto> getNotificationById(int id) async {
    final response = await dio.get('/notifications/$id');
    return NotificationDto.fromJson(response.data);
  }

  Future<void> deleteNotification(int id) async {
    await dio.delete('/notifications/$id');
  }

  Future<void> subscribeNotification(final String fcmToken) {
    return dio.post('/notifications/device', data: {
      'token': fcmToken,
    });
  }

  Future<void> unsubscribeNotification(final String fcmToken) {
    return dio.delete('/notifications/device', data: {
      'token': fcmToken,
    });
  }

  Future<void> allowExpirationNotifications() {
    return dio.post('/notifications/expiration/allow', data: {});
  }

  Future<void> disallowExpirationNotifications() {
    return dio.post('/notifications/expiration/deny', data: {});
  }
}
