// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class DeleteVoucher {
  DeleteVoucher({
    required VoucherRepositoryMixin voucherRepository,
  }) : _voucherRepository = voucherRepository;

  final VoucherRepositoryMixin _voucherRepository;

  Future<void> call({
    required int id,
  }) async {
    await _voucherRepository.deleteVoucher(id: id);
  }
}
