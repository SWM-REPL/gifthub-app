// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/repository/product.repository.dart';

class GetProduct {
  GetProduct({required ProductRepositoryMixin repository})
      : _repository = repository;

  final ProductRepositoryMixin _repository;

  Future<Product> call(int id) async {
    final product = await _repository.getProduct(id: id);
    return product;
  }
}
