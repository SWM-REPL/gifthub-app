// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/domain/repository/notice.repository.dart';

class GetNotices {
  GetNotices({required NoticeRepositoryMixin repository})
      : _repository = repository;

  final NoticeRepositoryMixin _repository;

  Future<List<Notice>> call() async {
    return await _repository.getNotices();
  }
}
