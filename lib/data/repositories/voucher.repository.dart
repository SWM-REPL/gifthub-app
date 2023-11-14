// 📦 Package imports:
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/giftcard.dto.dart';
import 'package:gifthub/data/dto/voucher.dto.dart';
import 'package:gifthub/data/sources/voucher.api.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherApi _voucherApi;

  VoucherRepositoryImpl(this._voucherApi);

  @override
  Future<List<int>> getVoucherIds(int userId) async {
    return await _voucherApi.getVoucherIds(userId);
  }

  @override
  Future<int> getPendingCount(int userId) async {
    return await _voucherApi.getPendingCount(userId);
  }

  @override
  Future<VoucherDto> getVoucherById(int id) {
    return _voucherApi.getVoucherById(id);
  }

  @override
  Future<void> createVoucherByValues({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  }) async {
    await _voucherApi.createVoucherByValues(
      barcode: barcode,
      expiresAt: DateFormat('yyyy-MM-dd').format(expiresAt),
      productName: productName,
      brandName: brandName,
    );
  }

  @override
  Future<void> createVoucherByTexts(
    List<String> texts,
    String filename,
  ) async {
    await _voucherApi.createVoucherByTexts(texts, filename);
  }

  @override
  Future<VoucherDto> updateVoucher(
    int id, {
    String? barcode,
    int? balance,
    DateTime? expiresAt,
    String? productName,
    String? brandName,
    bool? isChecked,
  }) async {
    return await _voucherApi.updateVoucherById(
      id,
      barcode: barcode,
      expiresAt:
          expiresAt != null ? DateFormat('yyyy-MM-dd').format(expiresAt) : null,
      productName: productName,
      brandName: brandName,
      balance: balance,
      isChecked: isChecked,
    );
  }

  @override
  Future<void> deleteVoucher(int id) async {
    await _voucherApi.deleteVoucherById(id);
  }

  @override
  Future<void> useVoucher(
    int id, {
    int? amount,
  }) async {
    await _voucherApi.useVoucher(
      id,
      amount: amount,
    );
  }

  @override
  Future<GiftcardDto> shareVoucher({
    required int id,
    required String message,
  }) async {
    return await _voucherApi.shareVoucher(
      id: id,
      message: message,
    );
  }

  @override
  Future<void> retrieveVoucher(int id) async {
    return await _voucherApi.retrieveVoucher(id: id);
  }

  @override
  Future<String> getPresignedUrlToUploadImage(String imageExtension) async {
    return await _voucherApi.getPresignedUrlToUploadImage(imageExtension);
  }

  @override
  Future<void> uploadImage(String imagePath, String uploadTarget) async {
    await _voucherApi.uploadImage(imagePath, uploadTarget);
  }

  @override
  Future<String> getImagePresignedUrl(int id) async {
    return await _voucherApi.getImagePresignedUrl(id);
  }
}
