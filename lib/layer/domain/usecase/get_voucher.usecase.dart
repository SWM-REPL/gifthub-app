// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class GetVoucher {
  GetVoucher(this._voucherRepository);

  final VoucherRepositoryMixin _voucherRepository;

  Future<Voucher> call(int id) async {
    return await _voucherRepository.getVoucher(id);
  }
}
