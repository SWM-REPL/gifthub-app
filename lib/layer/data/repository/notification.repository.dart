// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/notification.dto.dart';
import 'package:gifthub/layer/data/source/network/notification.api.dart';
import 'package:gifthub/layer/domain/repository/notification.repository.dart';

class NotificationRepository with NotificationRepositoryMixin {
  NotificationRepository({
    required NotificationApiMixin api,
  }) : _api = api;

  final NotificationApiMixin _api;

  @override
  Future<List<NotificationDto>> getNotifications() {
    return _api.getNotifications();
  }
}
