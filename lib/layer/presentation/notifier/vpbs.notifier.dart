// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher_ids.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/register_voucher.provider.dart';

class VPBsNotifier extends AutoDisposeAsyncNotifier<List<VPB>> {
  @override
  Future<List<VPB>> build() async {
    return await _fetch();
  }

  Future<void> addVoucher({
    String? imagePath,
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final registerVoucher = ref.watch(registerVoucherProvider);
      await registerVoucher(
        imagePath: imagePath,
        brandName: brandName,
        productName: productName,
        expiresAt: expiresAt,
        barcode: barcode,
      );
      ref.invalidate(voucherIdsProvider);
      return await _fetch();
    });
  }

  Future<List<VPB>> _fetch() async {
    final ids = await ref.watch(voucherIdsProvider.future);
    final vpbFutures = ids.map((id) => ref.watch(vpbProvider(id).future));
    final vpbs = await Future.wait(vpbFutures);
    for (final vpb in vpbs) {
      if (vpb.voucher.isUsable == false) {
        continue;
      }
      vpb.brand.totalCount++;
      vpb.brand.totalPrice += vpb.voucher.balance;
    }
    return vpbs;
  }
}

final vpbsProvider = AsyncNotifierProvider.autoDispose<VPBsNotifier, List<VPB>>(
  () => VPBsNotifier(),
);

final vouchersProvider = FutureProvider.autoDispose<List<Voucher>>((ref) async {
  final vpbs = await ref.watch(vpbsProvider.future);
  return vpbs.map((vpb) => vpb.voucher).toList();
});

final productsProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final vpbs = await ref.watch(vpbsProvider.future);
  return vpbs.map((vpb) => vpb.product).toList();
});

final brandsProvider = FutureProvider.autoDispose<List<Brand>>((ref) async {
  final vpbs = await ref.watch(vpbsProvider.future);
  final brands = vpbs.map((vpb) => vpb.brand).toSet();
  for (final brand in brands) {
    brand.totalPrice = 0;
    brand.totalCount = 0;
  }
  for (final vpb in vpbs) {
    if (vpb.voucher.isUsable == false) {
      continue;
    }

    vpb.brand.totalPrice += vpb.voucher.balance;
    vpb.brand.totalCount++;
  }
  return brands.where((brand) => brand.totalCount > 0).toList();
});
