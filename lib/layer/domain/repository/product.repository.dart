// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';

mixin ProductRepositoryMixin {
  Future<Product> getProduct(int id);
}
