// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

mixin VoucherRepositoryMixin {
  Future<Voucher> getVoucher(int id);
  Future<List<int>> getVoucherIds(int userId);
  Future<void> setVoucher(
    int id, {
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
  });
  Future<void> useVoucher(
    int id,
    int amount,
  );
}
