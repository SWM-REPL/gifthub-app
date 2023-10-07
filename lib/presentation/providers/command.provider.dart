// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/create_voucher_by_image.command.dart';
import 'package:gifthub/domain/commands/create_voucher_by_values.command.dart';
import 'package:gifthub/domain/commands/delete_voucher.command.dart';
import 'package:gifthub/domain/commands/fetch_brand.command.dart';
import 'package:gifthub/domain/commands/fetch_new_notification_count.command.dart';
import 'package:gifthub/domain/commands/fetch_notifications.command.dart';
import 'package:gifthub/domain/commands/update_voucher.command.dart';
import 'package:gifthub/domain/commands/use_voucher.command.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final fetchNewNotificationCountCommandProvider =
    Provider<FetchNewNotificationCountCommand>((ref) {
  return FetchNewNotificationCountCommand(
    notificationRepository: ref.watch(notificationRepositoryProvider),
  );
});

final fetchNotificationsCommandProvider =
    Provider<FetchNotificationsCommand>((ref) {
  return FetchNotificationsCommand(
    notificationRepository: ref.watch(notificationRepositoryProvider),
  );
});

final fetchBrandCommandProvider = Provider<FetchBrandCommand>((ref) {
  return FetchBrandCommand(
    brandRepository: ref.watch(brandRepositoryProvider),
  );
});

final createVoucherByValuesCommandProvider =
    Provider<CreateVoucherByValuesCommand>((ref) {
  return CreateVoucherByValuesCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  );
});

final createVoucherByImageCommandProvider =
    Provider<CreateVoucherByImageCommand>((ref) {
  return CreateVoucherByImageCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  );
});

final updateVoucherCommandProvider = Provider<UpdateVoucherCommand>((ref) {
  return UpdateVoucherCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  );
});

final deleteVoucherCommandProvider = Provider<DeleteVoucherCommand>((ref) {
  return DeleteVoucherCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  );
});

final useVoucherCommandProvider = Provider<UseVoucherCommand>((ref) {
  return UseVoucherCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
  );
});
