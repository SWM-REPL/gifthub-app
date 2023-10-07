// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class DeleteVoucherCommand {
  final VoucherRepository _voucherRepository;

  DeleteVoucherCommand({
    required VoucherRepository voucherRepository,
  }) : _voucherRepository = voucherRepository;

  Future<void> call(int id) async {
    await _voucherRepository.deleteVoucher(id);
  }
}
