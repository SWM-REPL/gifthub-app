import 'package:gifthub/layer/domain/entity/product.entity.dart';

mixin ProductRepositoryMixin {
  Future<Product> getProduct({required int id});
}
