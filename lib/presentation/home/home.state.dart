// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

class HomeState with EquatableMixin {
  final List<Brand> brands;
  final List<Voucher> filteredVouchers;
  final int pendingCount;

  HomeState({
    required this.brands,
    required this.filteredVouchers,
    required this.pendingCount,
  });

  bool get isEmpty => filteredVouchers.isEmpty && pendingCount == 0;

  @override
  List<Object?> get props => [
        brands,
        filteredVouchers,
        pendingCount,
      ];
}

final homeStateProvider = FutureProvider<HomeState>((ref) async {
  return HomeState(
    brands: await ref.watch(brandsProvider.future),
    filteredVouchers: await ref.watch(filteredVouchersProvider.future),
    pendingCount: await ref.watch(pendingCountProvider.future),
  );
});

final brandFilterProvider = StateProvider<Brand?>((ref) => null);

final filteredVouchersProvider = FutureProvider<List<Voucher>>((ref) async {
  final brandFilter = ref.watch(brandFilterProvider);
  final vouchers = await ref.watch(vouchersProvider.future);
  final products = await ref.watch(productsProvider.future);
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
