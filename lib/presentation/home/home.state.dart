// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

final brandFilterProvider = StateProvider<Brand?>((ref) => null);

final filteredVouchersProvider = FutureProvider<List<Voucher>>((ref) async {
  final brandFilter = ref.watch(brandFilterProvider);
  final vouchers = await ref.watch(vouchersProvider.future);
  final products = await ref.watch(productsProvider.future);
  final filteredVouchers = vouchers.where((voucher) {
    if (brandFilter == null) {
      return true;
    }
    final product = products.firstWhere((p) => p.id == voucher.productId);
    return product.brandId == brandFilter.id;
  }).toList();
  return filteredVouchers;
});

class BrandInfo with EquatableMixin {
  final int voucherCount;
  final int totalBalance;

  BrandInfo({
    required this.voucherCount,
    required this.totalBalance,
  });

  @override
  List<Object?> get props => [
        voucherCount,
        totalBalance,
      ];
}

final brandInfoProvider = FutureProvider<Map<int, BrandInfo>>((ref) async {
  final vouchers = await ref.watch(vouchersProvider.future);
  final products = await ref.watch(productsProvider.future);
  final brands = await ref.watch(brandsProvider.future);
  final brandInfos = <int, BrandInfo>{};
  for (final brand in brands) {
    brandInfos[brand.id] = BrandInfo(voucherCount: 0, totalBalance: 0);
  }
  for (final voucher in vouchers) {
    final product = products.firstWhere((p) => p.id == voucher.productId);
    final brandInfo = brandInfos[product.brandId]!;
    brandInfos[product.brandId] = BrandInfo(
      voucherCount: brandInfo.voucherCount + 1,
      totalBalance: brandInfo.totalBalance + voucher.balance,
    );
  }
  return brandInfos;
});

final pendingCountProvider = FutureProvider<int>((ref) async {
  final appUser = await ref.watch(appUserProvider.future);
  final pendingCount =
      await ref.watch(fetchPendingVoucherCountCommandProvider)(appUser.id);
  return pendingCount;
});

final notificationCountProvider = FutureProvider<int>((ref) async {
  final count = ref.watch(
    notificationsProvider.select((notifications) {
      final unreadNotis = notifications.where((n) => n.checkedAt == null);
      return unreadNotis.length;
    }),
  );
  return count;
});
