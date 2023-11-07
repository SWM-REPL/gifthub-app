// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final voucherIdsProvider = FutureProvider<List<int>>((ref) async {
  final appUser = await ref.watch(appUserProvider.future);
  final voucherRepository = ref.watch(voucherRepositoryProvider);
  return await voucherRepository.getVoucherIds(appUser.id);
});

final voucherProvider = FutureProvider.family<Voucher, int>((ref, id) async {
  final voucherRepository = ref.watch(voucherRepositoryProvider);
  return voucherRepository.getVoucherById(id);
});

final vouchersProvider = FutureProvider<List<Voucher>>((ref) async {
  final voucherIds = await ref.watch(voucherIdsProvider.future);
  final vouchers = await Future.wait(voucherIds.map((id) async {
    return await ref.watch(voucherProvider(id).future);
  }));
  vouchers.sort((a, b) {
    if (a.isUsable && !b.isUsable) {
      return -1;
    } else if (!a.isUsable && b.isUsable) {
      return 1;
    } else {
      return a.expiresAt.compareTo(b.expiresAt);
    }
  });
  return vouchers;
});

final brandIdProvider = FutureProvider.family<int, int>((ref, id) async {
  final voucher = await ref.watch(voucherProvider(id).future);
  final product = await ref.watch(productProvider(voucher.productId).future);
  return product.brandId;
});
