// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/regist_voucher.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/voucher.repository.provider.dart';

final _registVoucherProvider = Provider(
  (ref) => RegistVoucher(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  ),
);

final registVoucherProvider = FutureProvider.autoDispose.family<int, String>(
  (ref, imagePath) async {
    final registVoucher = ref.watch(_registVoucherProvider);
    return await registVoucher(imagePath);
  },
);
