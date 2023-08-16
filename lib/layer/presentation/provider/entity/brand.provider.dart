// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/presentation/provider/repository/brand.repository.provider.dart';

final brandProvider = FutureProvider.family<Brand, int>((ref, id) async {
  final brandRepository = ref.read(brandRepositoryProvider);
  return await brandRepository.getBrand(id);
});
