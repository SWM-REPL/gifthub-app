// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

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
  final voucherIds = await ref.watch(voucherIdsProvider.future);
  final brandIds = await Future.wait(
    voucherIds.map((id) => ref.watch(brandIdProvider(id).future)),
  );

  final Map<int, int> brandFrequency = {};
  for (final id in brandIds) {
    brandFrequency[id] = (brandFrequency[id] ?? 0) + 1;
  }

  final sortedUniqueBrandIds = brandFrequency.keys.toList()
    ..sort((a, b) => brandFrequency[b]!.compareTo(brandFrequency[a]!));

  final brands = await Future.wait(
    sortedUniqueBrandIds.map((id) => ref.watch(brandProvider(id).future)),
  );
  return brands;
});
