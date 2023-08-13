// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/voucher.repository.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

class GetVoucher {
  GetVoucher(this._voucherRepository);

  final VoucherRepository _voucherRepository;

  Future<Voucher> call(int id) async {
    return await _voucherRepository.getVoucher(id);
  }
}
