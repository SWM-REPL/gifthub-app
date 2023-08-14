// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_brand.provider.dart';

class BrandsNotifier extends FamilyAsyncNotifier<Brand, int> {
  @override
  Future<Brand> build(int arg) async {
    final getBrand = ref.watch(getBrandProvider);
    return await getBrand(arg);
  }
}

final brandProvider = AsyncNotifierProvider.family<BrandsNotifier, Brand, int>(
  () => BrandsNotifier(),
);
