// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/voucher.repository.dart';

class UseVoucher {
  UseVoucher(this._voucherRepository);

  final VoucherRepository _voucherRepository;

  Future<void> call(int id, int amount) async {
    await _voucherRepository.useVoucher(id, amount);
  }
}
