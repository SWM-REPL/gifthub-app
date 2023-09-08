// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/notice.repository.dart';

class UpdateFcmToken {
  UpdateFcmToken(this._noticeRepository);

  final NoticeRepositoryMixin _noticeRepository;

  Future<bool> call(String fcmToken) async {
    return await _noticeRepository.updateFcmToken(fcmToken);
  }
}
