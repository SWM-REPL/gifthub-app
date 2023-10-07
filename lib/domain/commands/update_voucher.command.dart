// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class UpdateVoucherCommand {
  final VoucherRepository _voucherRepository;

  UpdateVoucherCommand({
    required VoucherRepository voucherRepository,
  }) : _voucherRepository = voucherRepository;

  Future<void> call({
    required int id,
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  }) async {
    await _voucherRepository.updateVoucher(
      id,
      barcode: barcode,
      expiresAt: expiresAt,
      productName: productName,
      brandName: brandName,
    );
  }
}
