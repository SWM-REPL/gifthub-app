// 🌎 Project imports:
import 'package:gifthub/data/dto/brand.dto.dart';
import 'package:gifthub/data/sources/brand.api.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandApi _brandApi;

  BrandRepositoryImpl({required BrandApi brandApi}) : _brandApi = brandApi;

  @override
  Future<BrandDto> getBrandById(int id) {
    return _brandApi.getBrandById(id);
  }
}
