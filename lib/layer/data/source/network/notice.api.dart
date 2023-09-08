// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/notice.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin NoticeApiMixin {
  Future<List<NoticeDto>> getNotices();
  Future<bool> updateFcmToken(String fcmToken);
}

class NoticeApi with DioMixin, NoticeApiMixin {
  @override
  Future<List<NoticeDto>> getNotices() async {
    const String endpoint = '/notifications';

    final response = await dio.get(endpoint);
    final data = response.data as List<dynamic>;
    return data.map((e) => NoticeDto.fromJson(e)).toList();
  }

  @override
  Future<bool> updateFcmToken(String fcmToken) async {
    const String endpoint = '/notifications/device';

    final response = await dio.post(endpoint, data: {'token': fcmToken});
    return response.statusCode == 200;
  }
}
