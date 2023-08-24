// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/regist_voucher.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/voucher.repository.provider.dart';

final _registerVoucherProvider = Provider(
  (ref) => RegisterVoucher(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  ),
);

final registerVoucherProvider = FutureProvider.autoDispose.family<int, String>(
  (ref, imagePath) async {
    final registerVoucher = ref.watch(_registerVoucherProvider);
    return await registerVoucher(imagePath);
  },
);
