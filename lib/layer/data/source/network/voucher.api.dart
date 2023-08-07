// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/voucher.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin VoucherApiMixin {
  Future<VoucherDto> loadVoucher({
    required int id,
  });
  Future<List<int>> loadVoucherIds();
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
  Future<List<int>> loadVoucherIds() async {
    const String endpoint = '/vouchers';

    final response = await dio.get(endpoint);
    return (response.data as List).cast<int>();
  }
}
