// 🌎 Project imports:
import 'package:gifthub/data/dto/product.dto.dart';
import 'package:gifthub/data/sources/product.api.dart';
import 'package:gifthub/domain/repositories/product.repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi _productApi;

  ProductRepositoryImpl({required ProductApi productApi})
      : _productApi = productApi;

  @override
  Future<ProductDto> getProductById(int id) async {
    return _productApi.getProductsById(id);
  }
}
