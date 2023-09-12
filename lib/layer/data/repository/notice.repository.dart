// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/notice.dto.dart';
import 'package:gifthub/layer/data/dto/notices.dto.dart';
import 'package:gifthub/layer/data/source/network/notice.api.dart';
import 'package:gifthub/layer/domain/repository/notice.repository.dart';

class NoticeRepository with NoticeRepositoryMixin {
  NoticeRepository({
    required NoticeApiMixin api,
  }) : _api = api;

  final NoticeApiMixin _api;

  @override
  Future<NoticesDto> getNotices() {
    return _api.getNotices();
  }

  @override
  Future<NoticeDto> getNotice(int id) {
    return _api.getNotice(id);
  }

  @override
  Future<bool> updateFcmToken(String fcmToken) {
    return _api.updateFcmToken(fcmToken);
  }
}
