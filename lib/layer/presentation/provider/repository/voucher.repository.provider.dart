// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/voucher.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/voucher.api.provider.dart';

final voucherRepositoryProvider = Provider<VoucherRepository>(
  (ref) => VoucherRepository(
    api: ref.read(voucherApiProvider),
  ),
);
