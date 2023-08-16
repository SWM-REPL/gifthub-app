// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/provider/repository/voucher.repository.provider.dart';

final voucherProvider = FutureProvider.family<Voucher, int>((ref, id) async {
  final voucherRepository = ref.read(voucherRepositoryProvider);
  return await voucherRepository.getVoucher(id);
});
