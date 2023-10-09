// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';

class FetchBrandCommand extends Command {
  final BrandRepository _brandRepository;

  FetchBrandCommand({
    required BrandRepository brandRepository,
    required FirebaseAnalytics analytics,
  })  : _brandRepository = brandRepository,
        super('fetch_brand', analytics);

  Future<Brand> call(int id) async {
    try {
      final brand = await _brandRepository.getBrandById(id);
      logSuccess({'brandname': brand.name});
      return brand;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
