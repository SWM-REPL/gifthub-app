// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.state.dart';

class VoucherListStateNotifier extends AsyncNotifier<VoucherListState> {
  @override
  Future<VoucherListState> build() async {
    final appUser = await ref.watch(appUserProvider.future);

    final voucherIds = await ref.watch(voucherIdsProvider.future);
    final vouchers = await Future.wait(
      [for (final id in voucherIds) ref.watch(voucherProvider(id).future)],
    );
    final productIds = vouchers.map((voucher) => voucher.productId).toSet();
    final products = await Future.wait([
      for (final productId in productIds)
        ref.watch(productProvider(productId).future)
    ]);
    final brandIds = products.map((product) => product.brandId).toSet();
    final brands = await Future.wait([
      for (final brandId in brandIds) ref.watch(brandProvider(brandId).future)
    ]);

    final Map<int, int> totalBalance = {};
    for (final voucher in vouchers) {
      totalBalance.update(
        products.where((element) => element.id == voucher.productId).first.id,
        (value) => value + voucher.balance,
        ifAbsent: () => voucher.balance,
      );
    }

    final voucherRepository = ref.watch(voucherRepositoryProvider);

    return VoucherListState(
      appUser: appUser,
      vouchers: _sortVouchers(vouchers),
      brands: _sortBrands(vouchers, products, brands),
      pendingCount: await voucherRepository.getPendingCount(appUser.id),
      notificationCount:
          await ref.watch(fetchNewNotificationCountCommandProvider)(),
      brandTotalBalance: totalBalance,
    );
  }

  List<Voucher> _sortVouchers(
    final List<Voucher> vouchers,
  ) {
    vouchers.sort((a, b) {
      if ((a.isUsable && b.isUsable) || (!a.isUsable && !b.isUsable)) {
        return b.expiresAt.compareTo(a.expiresAt);
      } else if (a.isUsable) {
        return -1;
      } else {
        return 1;
      }
    });
    return vouchers;
  }

  List<Brand> _sortBrands(
    final List<Voucher> vouchers,
    final List<Product> products,
    final List<Brand> brands,
  ) {
    final productsMap = {
      for (final product in products) product.id: product,
    };
    final productCount = {
      for (final product in products)
        product.id: vouchers.where((v) => v.productId == product.id).length,
    };
    final brandCount = {
      for (final brand in brands)
        brand.id: productCount.entries
            .where((entry) => productsMap[entry.key]?.brandId == brand.id)
            .map((entry) => entry.value)
            .reduce((a, b) => a + b),
    };
    brands.sort((a, b) => brandCount[b.id]!.compareTo(brandCount[a.id]!));
    return brands;
  }
}

final voucherListStateProvider =
    AsyncNotifierProvider<VoucherListStateNotifier, VoucherListState>(
  () => VoucherListStateNotifier(),
);
