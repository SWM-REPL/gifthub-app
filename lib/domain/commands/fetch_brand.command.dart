// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';

class FetchBrandCommand {
  static const name = 'fetch_brand';

  final BrandRepository _brandRepository;
  final FirebaseAnalytics _analytics;

  FetchBrandCommand({
    required BrandRepository brandRepository,
    required FirebaseAnalytics analytics,
  })  : _brandRepository = brandRepository,
        _analytics = analytics;

  Future<Brand> call(int id) async {
    try {
      final brand = await _brandRepository.getBrandById(id);
      _analytics.logEvent(
        name: FetchBrandCommand.name,
        parameters: {
          'success': true,
          'brandname': brand.name,
        },
      );
      return brand;
    } catch (e) {
      _analytics.logEvent(
        name: FetchBrandCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
