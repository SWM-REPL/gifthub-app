// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';

abstract class ProductRepository {
  Future<Product> getProductById(int id);
}
