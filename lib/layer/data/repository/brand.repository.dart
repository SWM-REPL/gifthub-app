// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/brand.dto.dart';
import 'package:gifthub/layer/data/source/network/brand.api.dart';
import 'package:gifthub/layer/domain/repository/brand.repository.dart';

class BrandRepository with BrandRepositoryMixin {
  BrandRepository({
    required BrandApiMixin api,
  }) : _api = api;

  final BrandApiMixin _api;

  @override
  Future<BrandDto> getBrand(int id) async {
    final fetchedBrand = await _api.loadBrand(id: id);
    return fetchedBrand;
  }
}
