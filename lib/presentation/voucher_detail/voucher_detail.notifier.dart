// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher_detail/voucher_detail.state.dart';

class VoucherDetailStateNotifier
    extends AutoDisposeFamilyAsyncNotifier<VoucherDetailState, int> {
  @override
  Future<VoucherDetailState> build(int arg) async {
    final voucher = await ref.watch(voucherProvider(arg).future);
    final product = await ref.watch(productProvider(voucher.productId).future);
    final brand = await ref.watch(brandProvider(product.brandId).future);

    return VoucherDetailState(
      voucher: voucher,
      product: product,
      brand: brand,
    );
  }

  Future<void> delete() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final value = state.value!;
      await ref.watch(deleteVoucherCommandProvider)(value.voucher.id);
      ref.invalidate(voucherIdsProvider);
      return value;
    });
  }

  Future<void> useAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final value = state.value!;
      await _useVoucher(value.voucher.balance);
      return value;
    });
  }

  Future<void> use(int amount) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _useVoucher(amount);
      return state.value!;
    });
  }

  Future<void> _useVoucher(int? amount) async {
    final voucher = state.value!.voucher;
    ref.watch(useVoucherCommandProvider)(voucher.id, amount);
    ref.invalidate(voucherProvider(voucher.id));
  }
}

final voucherDetailStateProvider = AsyncNotifierProvider.family
    .autoDispose<VoucherDetailStateNotifier, VoucherDetailState, int>(
  () => VoucherDetailStateNotifier(),
);
