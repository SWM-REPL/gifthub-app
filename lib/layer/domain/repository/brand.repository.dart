// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';

mixin BrandRepositoryMixin {
  Future<Brand> getBrand(int id);
}
