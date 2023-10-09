// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final brandProvider = FutureProvider.family<Brand, int>((ref, id) async {
  final brandRepository = ref.watch(brandRepositoryProvider);
  return await brandRepository.getBrandById(id);
});
