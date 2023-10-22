// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final brandIdsProvider = FutureProvider<List<int>>((ref) async {
  final productIds = await ref.watch(productIdsProvider.future);
  final products = await Future.wait(productIds.map((id) async {
    return await ref.watch(productProvider(id).future);
  }));
  return products.map((product) => product.brandId).toSet().toList();
});

final brandProvider = FutureProvider.family<Brand, int>((ref, id) async {
  final brandRepository = ref.watch(brandRepositoryProvider);
  return await brandRepository.getBrandById(id);
});

final brandsProvider = FutureProvider<List<Brand>>((ref) async {
  final products = await ref.watch(productsProvider.future);
  final brandIds = await ref.watch(brandIdsProvider.future);
  final brands = await Future.wait(brandIds.map((id) async {
    return await ref.watch(brandProvider(id).future);
  }));
  brands.sort(
    (a, b) => products.where((p) => p.brandId == a.id).length.compareTo(
          products.where((p) => p.brandId == b.id).length,
        ),
  );
  return brands;
});
