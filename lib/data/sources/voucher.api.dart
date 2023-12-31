// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/giftcard.dto.dart';
import 'package:gifthub/data/dto/voucher.dto.dart';

class VoucherApi {
  final Dio dio;

  VoucherApi(this.dio);

  Future<List<int>> getVoucherIds(final int userId) async {
    final response = await dio.get('/vouchers', queryParameters: {
      'user_id': userId,
    });
    // ignore: avoid_dynamic_calls
    return List<int>.from(response.data['voucher_ids']);
  }

  Future<int> getPendingCount(final int userId) async {
    final response = await dio.get('/vouchers', queryParameters: {
      'user_id': userId,
    });
    // ignore: avoid_dynamic_calls
    return response.data['pending_count'];
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
    await dio.post('/vouchers/manual', data: {
      'barcode': barcode,
      'expires_at': expiresAt,
      'product_name': productName,
      'brand_name': brandName,
    });
  }

  Future<void> createVoucherByTexts(
    final List<String> texts,
    String filename,
  ) async {
    await dio.post('/vouchers', data: {
      'texts': texts,
      'filename': filename,
    });
  }

  Future<VoucherDto> updateVoucherById(
    final int id, {
    final String? barcode,
    final String? expiresAt,
    final String? productName,
    final String? brandName,
    final int? balance,
    final bool? isChecked,
  }) async {
    final response = await dio.patch('/vouchers/$id', data: {
      if (barcode != null) 'barcode': barcode,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (productName != null) 'product_name': productName,
      if (brandName != null) 'brand_name': brandName,
      if (balance != null) 'balance': balance,
      if (isChecked != null) 'is_checked': isChecked,
    });
    return VoucherDto.fromJson(response.data);
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
      'place': 'TEMPORARY_PLACE',
    });
  }

  Future<GiftcardDto> shareVoucher({
    required final int id,
    required final String message,
  }) async {
    final response = await dio.post('/vouchers/$id/share', data: {
      'message': message,
    });
    return GiftcardDto.fromJson(response.data);
  }

  Future<void> retrieveVoucher({
    required final int id,
  }) async {
    await dio.delete('/vouchers/$id/share');
  }

  Future<String> getPresignedUrlToUploadImage(String imageExtension) async {
    final response = await dio.get('/vouchers/images/$imageExtension');
    // ignore: avoid_dynamic_calls
    return response.data['presigned_url'];
  }

  Future<void> uploadImage(
    final String imagePath,
    final String uploadTarget,
  ) async {
    final file = File.fromUri(Uri.parse(imagePath));
    await Dio().put(
      uploadTarget,
      options: Options(
        headers: {
          Headers.contentTypeHeader: lookupMimeType(file.path),
          Headers.contentLengthHeader: file.lengthSync(),
        },
      ),
      data: file.openRead(),
    );
  }

  Future<String> getImagePresignedUrl(final int id) async {
    final response = await dio.get('/vouchers/$id/image');
    // ignore: avoid_dynamic_calls
    return response.data['presigned_url'];
  }
}
