// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CreateVoucherByValuesCommand {
  final VoucherRepository _voucherRepository;

  CreateVoucherByValuesCommand({
    required VoucherRepository voucherRepository,
  }) : _voucherRepository = voucherRepository;

  Future<void> call({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  }) async {
    await _voucherRepository.createVoucherByValues(
      barcode: barcode,
      expiresAt: expiresAt,
      productName: productName,
      brandName: brandName,
    );
  }
}
