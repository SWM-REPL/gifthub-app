// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';

mixin NoticeRepositoryMixin {
  Future<List<Notice>> getNotices();
}
