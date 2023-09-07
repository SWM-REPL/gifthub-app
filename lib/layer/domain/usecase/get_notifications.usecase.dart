// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/notification.repository.dart';

class GetNotifications {
  GetNotifications({required NotificationRepositoryMixin repository})
      : _repository = repository;

  final NotificationRepositoryMixin _repository;

  Future<void> call() async {
    await _repository.getNotifications();
  }
}
