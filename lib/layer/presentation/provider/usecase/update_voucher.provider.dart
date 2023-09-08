// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/update_voucher.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/voucher.repository.provider.dart';

final updateVoucherProvider = Provider(
  (ref) => UpdateVoucher(
    ref.read(voucherRepositoryProvider),
  ),
);
