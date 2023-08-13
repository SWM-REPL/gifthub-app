// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/domain/usecase/get_all_voucher_ids.dart';
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/provider/repository/voucher.repository.provider.dart';

final _getVoucherIdsProvider = Provider(
  (ref) => GetAllVoucherIds(
    repository: ref.watch(voucherRepositoryProvider),
  ),
);

class _VoucherIdsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<int>, User> {
  @override
  Future<List<int>> build(final User arg) async {
    final getVoucherIds = ref.watch(_getVoucherIdsProvider);
    return await getVoucherIds(arg.id);
  }
}

final _voucherIdsFamily = AsyncNotifierProvider.family
    .autoDispose<_VoucherIdsNotifier, List<int>, User>(
  () => _VoucherIdsNotifier(),
);

final voucherIdsProvider = Provider.autoDispose<AsyncValue<List<int>>>((ref) {
  final appUser = ref.watch(appUserProvider);
  return appUser.when(
    data: (user) => ref.watch(_voucherIdsFamily(user)),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});
