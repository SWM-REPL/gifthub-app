// 🌎 Project imports:
import 'package:gifthub/domain/entities/giftcard.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';

abstract class VoucherRepository {
  Future<List<int>> getVoucherIds(int userId);

  Future<int> getPendingCount(int userId);

  Future<Voucher> getVoucherById(int id);

  Future<void> createVoucherByValues({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  });

  Future<void> createVoucherByTexts(List<String> texts, String filename);

  Future<void> updateVoucher(
    int id, {
    String? barcode,
    int? balance,
    DateTime? expiresAt,
    String? productName,
    String? brandName,
    bool? isChecked,
  });

  Future<void> deleteVoucher(int id);

  Future<void> useVoucher(
    int id, {
    int? amount,
  });

  Future<Giftcard> shareVoucher({
    required int id,
    required String message,
  });

  Future<void> retrieveVoucher(int id);

  Future<String> getPresignedUrlToUploadImage(String imageExtension);

  Future<void> uploadImage(String imagePath, String uploadTarget);

  Future<String> getImagePresignedUrl(int id);
}
