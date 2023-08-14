// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/voucher.api.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class VoucherRepository with VoucherRepositoryMixin {
  VoucherRepository({
    required VoucherApiMixin api,
  }) : _api = api;

  final VoucherApiMixin _api;

  @override
  Future<Voucher> getVoucher(int id) async {
    final fetchedVoucher = await _api.loadVoucher(id: id);
    return fetchedVoucher;
  }

  @override
  Future<List<int>> getVoucherIds(int userId) async {
    final fetchedVoucherIds = await _api.loadVoucherIds(userId: userId);
    return fetchedVoucherIds;
  }

  @override
  Future<void> setVoucher(int id, Voucher voucher) async {
    return await _api.updateVoucher(id: id);
  }
}
