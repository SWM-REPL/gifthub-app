// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/repository/brand.repository.dart';

class GetBrand {
  GetBrand({required BrandRepositoryMixin repository})
      : _repository = repository;

  final BrandRepositoryMixin _repository;

  Future<Brand> call(int id) async {
    final brand = await _repository.getBrand(id: id);
    return brand;
  }
}
