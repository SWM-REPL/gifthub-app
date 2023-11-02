// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

final brandFilterProvider = StateProvider<Brand?>((ref) => null);

final filteredVouchersProvider = FutureProvider<List<Voucher>>((ref) async {
  final vouchers = await ref.watch(vouchersProvider.future);
  final products = await ref.watch(productsProvider.future);
  final brandFilter = ref.watch(brandFilterProvider);
  final filteredVouchers = vouchers.where((voucher) {
    if (brandFilter == null) {
      return true;
    }
    final product =
        products.firstWhere((product) => product.id == voucher.productId);
    return product.brandId == brandFilter.id;
  }).toList();
  return filteredVouchers;
});

final pendingCountProvider = FutureProvider<int>((ref) async {
  final appUser = await ref.watch(appUserProvider.future);
  final pendingCount =
      await ref.watch(fetchPendingVoucherCountCommandProvider)(appUser.id);
  return pendingCount;
});
