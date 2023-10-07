// 🌎 Project imports:
import 'package:gifthub/domain/entities/voucher.entity.dart';

abstract class VoucherRepository {
  Future<List<int>> getVoucherIds(int userId);

  Future<Voucher> getVoucherById(int id);

  Future<void> createVoucherByValues({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  });

  Future<void> createVoucherByTexts(List<String> texts);

  Future<void> updateVoucher(
    int id, {
    String? barcode,
    DateTime? expiresAt,
    String? productName,
    String? brandName,
    int? balance,
  });

  Future<void> deleteVoucher(int id);

  Future<void> useVoucher(
    int id, {
    required int amount,
  });
}
