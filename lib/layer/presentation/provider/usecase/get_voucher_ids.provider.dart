// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_all_voucher_ids.dart';
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/provider/repository/voucher.repository.provider.dart';

final _getVoucherIdsProvider = Provider(
  (ref) => GetAllVoucherIds(
    repository: ref.watch(voucherRepositoryProvider),
  ),
);

final voucherIdsProvider = FutureProvider((ref) async {
  final appUser = await ref.watch(appUserProvider.future);
  final getVoucherIds = ref.watch(_getVoucherIdsProvider);
  return await getVoucherIds(appUser.id);
});
