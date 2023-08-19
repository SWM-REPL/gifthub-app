// 📦 Package imports:
import 'package:dio/dio.dart' as dio_library;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/voucher.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin VoucherApiMixin {
  Future<VoucherDto> loadVoucher({
    required int id,
  });
  Future<List<int>> loadVoucherIds({
    required int userId,
  });
  Future<void> updateVoucher(
    int id, {
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
  });
  Future<void> useVoucher({
    required int id,
    required int amount,
  });
  Future<String> uploadImage({
    required String imagePath,
  });
  Future<int> registVoucher({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
    required String imageUrl,
  });
}

class VoucherApi with DioMixin, VoucherApiMixin {
  @override
  Future<VoucherDto> loadVoucher({
    required int id,
  }) async {
    final String endpoint = '/vouchers/$id';

    final response = await dio.get(endpoint);
    return VoucherDto.fromJson(response.data);
  }

  @override
  Future<List<int>> loadVoucherIds({
    required int userId,
  }) async {
    const String endpoint = '/vouchers';

    final response = await dio.get(
      endpoint,
      queryParameters: {
        'user_id': userId,
      },
    );
    return (response.data as List).cast<int>();
  }

  @override
  Future<void> updateVoucher(
    int id, {
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
  }) async {
    final String endpoint = '/vouchers/$id';
    final dateFormatter = DateFormat('yyyy-MM-dd');

    await dio.patch(
      endpoint,
      data: {
        'brand_name': brandName,
        'product_name': productName,
        if (expiresAt != null) 'expires_at': dateFormatter.format(expiresAt),
        'barcode': barcode,
      },
    );
  }

  @override
  Future<void> useVoucher({
    required int id,
    required int amount,
  }) async {
    final String endpoint = '/vouchers/$id/usage';

    await dio.post(
      endpoint,
      data: {
        'amount': amount,
        'place': 'Not specified',
      },
    );
  }

  @override
  Future<String> uploadImage({
    required String imagePath,
  }) async {
    const String endpoint = '/vouchers/images';

    final imageFile = await dio_library.MultipartFile.fromFile(imagePath,
        filename: const Uuid().v4());
    final response = await dio.post(
      endpoint,
      data: {
        'image_file': imageFile,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return data['url'];
  }

  @override
  Future<int> registVoucher({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
    required String imageUrl,
  }) async {
    const String endpoint = '/vouchers';
    final dateFormatter = DateFormat('yyyy-MM-dd');

    final response = await dio.post(
      endpoint,
      data: {
        'barcode': barcode,
        'expires_at': dateFormatter.format(expiresAt),
        'product_name': productName,
        'brand_name': brandName,
        'image_url': imageUrl,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return data['id'];
  }
}
