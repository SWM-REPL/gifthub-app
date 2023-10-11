// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
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
    if (appUser == null) {
      throw UnauthorizedException();
    }
    return VoucherListState(
      appUser: appUser,
      vouchers: await _fetchVouchers(),
      brands: await _fetchBrands(),
      pendingCount: await _fetchPendingCount(),
      notificationCount: await _fetchNotificationCount(),
    );
  }

  Future<List<Voucher>> _fetchVouchers() async {
    final ids = await ref.watch(voucherIdsProvider.future);
    final vouchers = await Future.wait(
      [for (final id in ids) ref.watch(voucherProvider(id).future)],
    );
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

  Future<int> _fetchPendingCount() async {
    final appUser = await ref.watch(appUserProvider.future);
    if (appUser == null) {
      throw UnauthorizedException();
    }

    final voucherRepository = ref.watch(voucherRepositoryProvider);
    final pendingCount = await voucherRepository.getPendingCount(appUser.id);
    return pendingCount;
  }

  Future<List<Brand>> _fetchBrands() async {
    final ids = await ref.watch(voucherIdsProvider.future);
    final vouchers = await Future.wait(
      [for (final id in ids) ref.watch(voucherProvider(id).future)],
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
    return brands;
  }

  Future<int> _fetchNotificationCount() async {
    final fetchNewNotificationCountCommand =
        ref.watch(fetchNewNotificationCountCommandProvider);
    return await fetchNewNotificationCountCommand();
  }
}

final voucherListStateProvider =
    AsyncNotifierProvider<VoucherListStateNotifier, VoucherListState>(
  () => VoucherListStateNotifier(),
);
