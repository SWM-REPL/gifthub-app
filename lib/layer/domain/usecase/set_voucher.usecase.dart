// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class SetVoucher {
  SetVoucher(this._voucherRepository);

  final VoucherRepositoryMixin _voucherRepository;

  Future<void> call(int id, Voucher voucher) async {
    return await _voucherRepository.setVoucher(id, voucher);
  }
}
