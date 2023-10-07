// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';

class FetchBrandCommand {
  final BrandRepository _brandRepository;

  FetchBrandCommand({
    required BrandRepository brandRepository,
  }) : _brandRepository = brandRepository;

  Future<Brand> call(int id) async {
    final brand = await _brandRepository.getBrandById(id);
    return brand;
  }
}
