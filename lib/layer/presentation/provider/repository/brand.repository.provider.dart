// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/brand.repository.dart';
import 'package:gifthub/layer/presentation/provider/repository/brand.api.provider.dart';

final brandRepositoryProvider = Provider<BrandRepository>(
  (ref) => BrandRepository(
    api: ref.read(brandApiProvider),
  ),
);
