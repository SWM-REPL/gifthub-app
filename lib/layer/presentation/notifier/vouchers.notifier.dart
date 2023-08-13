// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher.provider.dart';

class VoucherNotifier extends FamilyAsyncNotifier<Voucher, int> {
  @override
  Future<Voucher> build(final int arg) async {
    final getVoucher = ref.watch(getVoucherProvider);
    return await getVoucher(arg);
  }
}

final voucherProvider =
    AsyncNotifierProvider.family<VoucherNotifier, Voucher, int>(
  () => VoucherNotifier(),
);
