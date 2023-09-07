// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notification.entity.dart';

mixin NotificationRepositoryMixin {
  Future<List<Notification>> getNotifications();
}
