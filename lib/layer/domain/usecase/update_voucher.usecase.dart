// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class UpdateVoucher {
  UpdateVoucher(this._voucherRepository);

  final VoucherRepositoryMixin _voucherRepository;

  Future<void> call(
    int id, {
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
    int? balance,
  }) async {
    return await _voucherRepository.setVoucher(
      id,
      brandName: brandName,
      productName: productName,
      expiresAt: expiresAt,
      barcode: barcode,
      balance: balance,
    );
  }
}
