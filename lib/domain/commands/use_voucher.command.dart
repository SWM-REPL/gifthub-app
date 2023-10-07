// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class UseVoucherCommand {
  final VoucherRepository _voucherRepository;

  UseVoucherCommand({
    required VoucherRepository voucherRepository,
  }) : _voucherRepository = voucherRepository;

  Future<void> call(int id, int amount) async {
    await _voucherRepository.useVoucher(id, amount: amount);
  }
}
