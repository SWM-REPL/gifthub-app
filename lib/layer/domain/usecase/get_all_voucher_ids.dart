// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class GetAllVoucherIds {
  GetAllVoucherIds({
    required VoucherRepositoryMixin repository,
  }) : _repository = repository;
  final VoucherRepositoryMixin _repository;
  Future<List<int>> call(int userId) async {
    final list = await _repository.getVoucherIds(userId);
    return list;
  }
}
