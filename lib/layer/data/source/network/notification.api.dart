// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/notification.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin NotificationApiMixin {
  Future<List<NotificationDto>> getNotifications();
}

class NotificationApi with DioMixin, NotificationApiMixin {
  @override
  Future<List<NotificationDto>> getNotifications() async {
    const String endpoint = '/notifications';

    final response = await dio.get(endpoint);
    final data = response.data as List<dynamic>;
    return data.map((e) => NotificationDto.fromJson(e)).toList();
  }
}
