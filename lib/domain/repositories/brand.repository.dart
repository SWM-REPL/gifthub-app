// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';

abstract class BrandRepository {
  Future<Brand> getBrandById(int id);
}
