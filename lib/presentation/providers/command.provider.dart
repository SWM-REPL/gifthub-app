// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/create_voucher_by_image.command.dart';
import 'package:gifthub/domain/commands/create_voucher_by_values.command.dart';
import 'package:gifthub/domain/commands/delete_voucher.command.dart';
import 'package:gifthub/domain/commands/deregister.command.dart';
import 'package:gifthub/domain/commands/fetch_brand.command.dart';
import 'package:gifthub/domain/commands/fetch_new_notification_count.command.dart';
import 'package:gifthub/domain/commands/fetch_notifications.command.dart';
import 'package:gifthub/domain/commands/sign_out.command.dart';
import 'package:gifthub/domain/commands/update_voucher.command.dart';
import 'package:gifthub/domain/commands/use_voucher.command.dart';
import 'package:gifthub/presentation/providers/event.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final fetchNewNotificationCountCommandProvider =
    Provider<FetchNewNotificationCountCommand>((ref) {
  return FetchNewNotificationCountCommand(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final fetchNotificationsCommandProvider =
    Provider<FetchNotificationsCommand>((ref) {
  return FetchNotificationsCommand(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final fetchBrandCommandProvider = Provider<FetchBrandCommand>((ref) {
  return FetchBrandCommand(
    brandRepository: ref.watch(brandRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final createVoucherByValuesCommandProvider =
    Provider<CreateVoucherByValuesCommand>((ref) {
  return CreateVoucherByValuesCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final createVoucherByImageCommandProvider =
    Provider<CreateVoucherByImageCommand>((ref) {
  return CreateVoucherByImageCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final updateVoucherCommandProvider = Provider<UpdateVoucherCommand>((ref) {
  return UpdateVoucherCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final deleteVoucherCommandProvider = Provider<DeleteVoucherCommand>((ref) {
  return DeleteVoucherCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final useVoucherCommandProvider = Provider<UseVoucherCommand>((ref) {
  return UseVoucherCommand(
    voucherRepository: ref.watch(voucherRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final signOutCommandProvider = Provider<SignOutCommand>((ref) {
  return SignOutCommand(
    authRepository: ref.watch(authRepositoryProvider),
    notificationRepository: ref.watch(notificationRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final deregisterCommandProvider = Provider<DeregisterCommand>((ref) {
  return DeregisterCommand(
    authRepository: ref.watch(authRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});
