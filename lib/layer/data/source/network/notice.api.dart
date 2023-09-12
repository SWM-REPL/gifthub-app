// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/notice.dto.dart';
import 'package:gifthub/layer/data/dto/notices.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin NoticeApiMixin {
  Future<NoticesDto> getNotices();
  Future<NoticeDto> getNotice(int id);
  Future<bool> updateFcmToken(String fcmToken);
}

class NoticeApi with DioMixin, NoticeApiMixin {
  @override
  Future<NoticesDto> getNotices() async {
    const String endpoint = '/notifications';

    final response = await dio.get(endpoint);
    final data = response.data as List<dynamic>;
    return NoticesDto.fromJson(data.cast<Map<String, dynamic>>());
  }

  @override
  Future<NoticeDto> getNotice(int id) async {
    final String endpoint = '/notifications/$id';

    final response = await dio.get(endpoint);
    final data = response.data;
    return NoticeDto.fromJson(data);
  }

  @override
  Future<bool> updateFcmToken(String fcmToken) async {
    const String endpoint = '/notifications/device';

    final response = await dio.post(endpoint, data: {'token': fcmToken});
    return response.statusCode == 200;
  }
}
