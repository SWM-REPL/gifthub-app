// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/provider/entity/brand.provider.dart';
import 'package:gifthub/layer/presentation/provider/entity/product.provider.dart';
import 'package:gifthub/layer/presentation/provider/entity/voucher.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/delete_voucher.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher_ids.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/set_voucher.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/use_voucher.provider.dart';

class VPB with EquatableMixin {
  VPB(this.voucher, this.product, this.brand);

  final Voucher voucher;
  final Product product;
  final Brand brand;

  @override
  List<Object?> get props => [voucher.id, product.id, brand.id];
}

class VPBNotifier extends AutoDisposeFamilyAsyncNotifier<VPB, int> {
  late int _voucherId;

  @override
  Future<VPB> build(final int arg) async {
    _voucherId = arg;
    return await _fetch();
  }

  Future<void> useVoucher(int amount) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useVoucher = ref.watch(useVoucherProvider);
      await useVoucher(_voucherId, amount);
      ref.invalidate(voucherProvider(_voucherId));
      return await _fetch();
    });
  }

  Future<void> editVoucher({
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
    int? balance,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final setVoucher = ref.watch(setVoucherProvider);
      await setVoucher(
        _voucherId,
        brandName: brandName,
        productName: productName,
        expiresAt: expiresAt,
        barcode: barcode,
        balance: balance,
      );
      ref.invalidate(voucherProvider(_voucherId));
      return await _fetch();
    });
  }

  Future<void> deleteVoucher() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deleteVoucher = ref.watch(deleteVoucherProvider);
      await deleteVoucher(id: _voucherId);
      ref.invalidate(voucherIdsProvider);
      return await _fetch();
    });
  }

  Future<VPB> _fetch() async {
    final voucher = await ref.watch(voucherProvider(_voucherId).future);
    final product = await ref.watch(productProvider(voucher.productId).future);
    final brand = await ref.watch(brandProvider(product.brandId).future);
    return VPB(voucher, product, brand);
  }
}

final vpbProvider =
    AsyncNotifierProvider.family.autoDispose<VPBNotifier, VPB, int>(() {
  return VPBNotifier();
});
