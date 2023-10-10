// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/voucher.dto.dart';

class VoucherApi {
  final Dio dio;

  VoucherApi(this.dio);

  Future<List<int>> getVoucherIds(final int userId) async {
    final response = await dio.get('/vouchers', queryParameters: {
      'user_id': userId,
    });
    return List<int>.from(response.data);
  }

  Future<VoucherDto> getVoucherById(final int id) async {
    final response = await dio.get('/vouchers/$id');
    return VoucherDto.fromJson(response.data);
  }

  Future<void> createVoucherByValues({
    required final String barcode,
    required final String expiresAt,
    required final String productName,
    required final String brandName,
  }) async {
    await dio.post('/vouchers', data: {
      'barcode': barcode,
      'expires_at': expiresAt,
      'product_name': productName,
      'brand_name': brandName,
    });
  }

  Future<void> createVoucherByTexts(final List<String> texts) async {
    await dio.post('/vouchers/test', data: {
      'texts': texts,
    });
  }

  Future<void> updateVoucherById(
    final int id, {
    final String? barcode,
    final String? expiresAt,
    final String? productName,
    final String? brandName,
    final int? balance,
  }) async {
    await dio.patch('/vouchers/$id', data: {
      'barcode': barcode,
      'expires_at': expiresAt,
      'product_name': productName,
      'brand_name': brandName,
      'balance': balance,
    });
  }

  Future<void> deleteVoucherById(final int id) async {
    await dio.delete('/vouchers/$id');
  }

  Future<String> uploadVoucherImage(final String imagePath) async {
    throw UnimplementedError();
  }

  Future<void> useVoucher(
    final int id, {
    final int? amount,
  }) async {
    await dio.post('/vouchers/$id/usage', data: {
      'amount': amount,
    });
  }
}
