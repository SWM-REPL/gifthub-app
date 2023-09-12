// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/domain/repository/notice.repository.dart';

class GetNotice {
  GetNotice({required NoticeRepositoryMixin repository})
      : _repository = repository;

  final NoticeRepositoryMixin _repository;

  Future<Notice> call(int id) async {
    return await _repository.getNotice(id);
  }
}
