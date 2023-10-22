// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

final productIdsProvider = FutureProvider<List<int>>((ref) async {
  final voucherIds = await ref.watch(voucherIdsProvider.future);
  final vouchers = await Future.wait(voucherIds.map((id) async {
    return await ref.watch(voucherProvider(id).future);
  }));
  return vouchers.map((voucher) => voucher.productId).toSet().toList();
});

final productProvider = FutureProvider.family<Product, int>((ref, id) async {
  final productRepository = ref.watch(productRepositoryProvider);
  return await productRepository.getProductById(id);
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final productIds = await ref.watch(productIdsProvider.future);
  final products = await Future.wait(productIds.map((id) async {
    return await ref.watch(productProvider(id).future);
  }));
  return products;
});
