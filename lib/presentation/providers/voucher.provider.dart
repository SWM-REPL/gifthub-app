// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final voucherIdsProvider = FutureProvider<List<int>>((ref) async {
  final appUser = await ref.watch(appUserProvider.future);
  if (appUser == null) {
    throw UnauthorizedException();
  }

  final voucherRepository = ref.watch(voucherRepositoryProvider);
  return await voucherRepository.getVoucherIds(appUser.id);
});

final voucherProvider = FutureProvider.family<Voucher, int>((ref, id) async {
  final voucherRepository = ref.watch(voucherRepositoryProvider);
  return voucherRepository.getVoucherById(id);
});
