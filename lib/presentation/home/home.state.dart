// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

class HomeState with EquatableMixin {
  final List<Brand> brands;
  final List<Voucher> filteredVouchers;
  final Map<Brand, int> brandVoucherCount;
  final Map<Brand, int> brandTotalBalance;
  final int pendingCount;

  HomeState({
    Brand? brandFilter,
    required List<Voucher> vouchers,
    required List<Product> products,
    required this.brands,
    required this.pendingCount,
  })  : brandVoucherCount = {},
        brandTotalBalance = {},
        filteredVouchers = vouchers.where((voucher) {
          if (brandFilter == null) {
            return true;
          }
          final product = products.firstWhere((p) => p.id == voucher.productId);
          return product.brandId == brandFilter.id;
        }).toList() {
    for (final brand in brands) {
      brandVoucherCount[brand] = 0;
      brandTotalBalance[brand] = 0;
    }

    for (final voucher in vouchers) {
      final product = products.firstWhere((p) => p.id == voucher.productId);
      final brand = brands.firstWhere((b) => b.id == product.brandId);
      brandVoucherCount[brand] = brandVoucherCount[brand]! + 1;
      brandTotalBalance[brand] = brandTotalBalance[brand]! + voucher.balance;
    }
  }

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
    brandFilter: ref.watch(brandFilterProvider),
    vouchers: await ref.watch(vouchersProvider.future),
    products: await ref.watch(productsProvider.future),
    brands: await ref.watch(brandsProvider.future),
    pendingCount: await ref.watch(pendingCountProvider.future),
  );
});

final brandFilterProvider = StateProvider<Brand?>((ref) => null);

final pendingCountProvider = FutureProvider<int>((ref) async {
  final appUser = await ref.watch(appUserProvider.future);
  final pendingCount =
      await ref.watch(fetchPendingVoucherCountCommandProvider)(appUser.id);
  return pendingCount;
});
