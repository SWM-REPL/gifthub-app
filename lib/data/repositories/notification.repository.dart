// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/notification.dto.dart';
import 'package:gifthub/data/sources/notification.api.dart';
import 'package:gifthub/data/sources/notification.storage.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApi _notificationApi;
  final NotificationStorage _notificationStorage;

  NotificationRepositoryImpl({
    required NotificationApi notificationApi,
    required NotificationStorage notificationStorage,
  })  : _notificationApi = notificationApi,
        _notificationStorage = notificationStorage;

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
    // await _notificationApi.deleteNotification(id);
    showSnackBar(const Text('준비중입니다.'));
  }

  @override
  Future<void> saveDeviceToken(String fcmToken) async {
    await _notificationStorage.saveDeviceToken(fcmToken);
  }

  @override
  Future<String?> getDeviceToken() async {
    return await _notificationStorage.loadDeviceToken();
  }

  @override
  Future<void> deleteDeviceToken() async {
    await _notificationStorage.deleteDeviceToken();
  }

  @override
  Future<void> subscribeNotification(String fcmToken) async {
    await _notificationApi.subscribeNotification(fcmToken);
  }
}
