// 📦 Package imports:
import 'package:intl/intl.dart';

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
}
