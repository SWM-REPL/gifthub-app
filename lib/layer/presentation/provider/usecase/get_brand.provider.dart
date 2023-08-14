// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_brand_provider.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/brand.repository.provider.dart';

final getBrandProvider = Provider(
  (ref) => GetBrand(
    repository: ref.read(brandRepositoryProvider),
  ),
);
