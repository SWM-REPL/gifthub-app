import 'package:gifthub/layer/data/dto/product.dto.dart';
import 'package:gifthub/layer/data/source/network/product.api.dart';
import 'package:gifthub/layer/domain/repository/product.repository.dart';

class ProductRepository with ProductRepositoryMixin {
  ProductRepository({
    required ProductApiMixin api,
  }) : _api = api;

  final ProductApiMixin _api;

  @override
  Future<ProductDto> getProduct({required int id}) async {
    final fetchedProduct = await _api.loadProduct(id: id);
    return fetchedProduct;
  }
}
