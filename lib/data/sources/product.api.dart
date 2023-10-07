// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/product.dto.dart';

class ProductApi {
  final Dio dio;

  ProductApi(this.dio);

  Future<ProductDto> getProductsById(int id) async {
    final response = await dio.get('/products/$id');
    return ProductDto.fromJson(response.data);
  }
}
