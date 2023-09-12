// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/domain/entity/notices.entity.dart';

mixin NoticeRepositoryMixin {
  Future<Notices> getNotices();
  Future<Notice> getNotice(int id);
  Future<bool> updateFcmToken(String fcmToken);
}
