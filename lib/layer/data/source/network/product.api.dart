// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/product.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin ProductApiMixin {
  Future<ProductDto> loadProduct({
    required int id,
  });
}

class ProductApi with DioMixin, ProductApiMixin {
  @override
  Future<ProductDto> loadProduct({
    required int id,
  }) async {
    final String endpoint = '/products/$id';

    final response = await dio.get(endpoint);
    return ProductDto.fromJson(response.data);
  }
}
