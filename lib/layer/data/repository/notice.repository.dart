// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/notice.dto.dart';
import 'package:gifthub/layer/data/source/network/notice.api.dart';
import 'package:gifthub/layer/domain/repository/notice.repository.dart';

class NoticeRepository with NoticeRepositoryMixin {
  NoticeRepository({
    required NoticeApiMixin api,
  }) : _api = api;

  final NoticeApiMixin _api;

  @override
  Future<List<NoticeDto>> getNotices() {
    return _api.getNotices();
  }
}
