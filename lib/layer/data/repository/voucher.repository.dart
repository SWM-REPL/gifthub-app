// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/voucher.api.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class VoucherRepository with VoucherRepositoryMixin {
  VoucherRepository({
    required VoucherApiMixin api,
  }) : _api = api;

  final VoucherApiMixin _api;

  @override
  Future<Voucher> getVoucher(int id) async {
    final fetchedVoucher = await _api.loadVoucher(id: id);
    return fetchedVoucher;
  }

  @override
  Future<List<int>> getVoucherIds(int userId) async {
    final fetchedVoucherIds = await _api.loadVoucherIds(userId: userId);
    return fetchedVoucherIds;
  }

  @override
  Future<void> setVoucher(
    int id, {
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
    int? balance,
  }) async {
    return await _api.updateVoucher(
      id,
      brandName: brandName,
      productName: productName,
      expiresAt: expiresAt,
      barcode: barcode,
      balance: balance,
    );
  }

  @override
  Future<void> useVoucher(int id, int amount) async {
    return await _api.useVoucher(
      id: id,
      amount: amount,
    );
  }

  @override
  Future<String> uploadImage(String imagePath) async {
    return await _api.uploadImage(imagePath: imagePath);
  }

  @override
  Future<int> registerVoucher({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
    String? imageUrl,
  }) async {
    return await _api.registerVoucher(
      barcode: barcode,
      expiresAt: expiresAt,
      productName: productName,
      brandName: brandName,
      imageUrl: imageUrl,
    );
  }
}
