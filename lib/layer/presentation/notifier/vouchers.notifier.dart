// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/set_voucher.provider.dart';

class VoucherNotifier extends FamilyAsyncNotifier<Voucher, int> {
  late int _id;

  @override
  Future<Voucher> build(final int arg) async {
    _id = arg;
    final getVoucher = ref.watch(getVoucherProvider);
    return await getVoucher(_id);
  }

  Future<void> updateVoucher(final Voucher voucher) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final getVoucher = ref.watch(getVoucherProvider);
      final setVoucher = ref.watch(setVoucherProvider);
      await setVoucher(_id, voucher);
      return await getVoucher(_id);
    });
  }
}

final voucherProvider =
    AsyncNotifierProvider.family<VoucherNotifier, Voucher, int>(
  () => VoucherNotifier(),
);
