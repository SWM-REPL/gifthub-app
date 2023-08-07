import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/domain/usecase/get_all_vouchers.usecase.dart';
import 'package:gifthub/layer/presentation/provider/domain.provider.dart';

class VouchersNotifier extends AsyncNotifier<List<Voucher>> {
  late final GetAllVouchers _getAllVouchers;

  @override
  Future<List<Voucher>> build() async {
    _getAllVouchers = ref.watch(getAllVouchersProvider);
    return await _getAllVouchers();
  }

  Future<void> fetchVouchers() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final vouchers = await _getAllVouchers();
      return vouchers;
    });
  }
}
