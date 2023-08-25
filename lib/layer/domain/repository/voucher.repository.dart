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
    int? balance,
  });
  Future<void> useVoucher(
    int id,
    int amount,
  );
  Future<String> uploadImage(
    String imagePath,
  );
  Future<int> registerVoucher({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
    String? imageUrl,
  });
  Future<void> deleteVoucher({
    required int id,
  });
}
