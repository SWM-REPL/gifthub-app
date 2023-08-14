// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/brand.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin BrandApiMixin {
  Future<BrandDto> loadBrand({
    required int id,
  });
}

class BrandApi with DioMixin, BrandApiMixin {
  @override
  Future<BrandDto> loadBrand({
    required int id,
  }) async {
    final String endpoint = '/brands/$id';

    final response = await dio.get(endpoint);
    return BrandDto.fromJson(response.data);
  }
}
