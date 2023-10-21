// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/create_voucher_by_image.command.dart';
import 'package:gifthub/domain/commands/create_voucher_by_values.command.dart';
import 'package:gifthub/domain/commands/delete_voucher.command.dart';
import 'package:gifthub/domain/commands/deregister.command.dart';
import 'package:gifthub/domain/commands/fetch_brand.command.dart';
import 'package:gifthub/domain/commands/fetch_new_notification_count.command.dart';
import 'package:gifthub/domain/commands/fetch_notification.command.dart';
import 'package:gifthub/domain/commands/fetch_notifications.command.dart';
import 'package:gifthub/domain/commands/invoke_oauth.command.dart';
import 'package:gifthub/domain/commands/revoke_oauth.command.dart';
import 'package:gifthub/domain/commands/sign_in_with_apple.command.dart';
import 'package:gifthub/domain/commands/sign_in_with_google.command.dart';
import 'package:gifthub/domain/commands/sign_in_with_kakao.command.dart';
import 'package:gifthub/domain/commands/sign_in_with_naver.command.dart';
import 'package:gifthub/domain/commands/sign_in_with_password.command.dart';
import 'package:gifthub/domain/commands/sign_out.command.dart';
import 'package:gifthub/domain/commands/subscribe_notification.command.dart';
import 'package:gifthub/domain/commands/unsubscribe_notification.command.dart';
import 'package:gifthub/domain/commands/update_user.command.dart';
import 'package:gifthub/domain/commands/update_voucher.command.dart';
import 'package:gifthub/domain/commands/use_voucher.command.dart';
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

final fetchNotificationCommandProvider =
    Provider<FetchNotificationCommand>((ref) {
  return FetchNotificationCommand(
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

final signInWithPasswordCommandProvider =
    Provider<SignInWithPasswordCommand>((ref) {
  return SignInWithPasswordCommand(
    authRepository: ref.watch(authRepositoryProvider),
    tokenRepository: ref.watch(tokenRepositoryProvider),
    notificationRepository: ref.watch(notificationRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final signInWithAppleCommandProvider = Provider<SignInWithAppleCommand>((ref) {
  return SignInWithAppleCommand(
    authRepository: ref.watch(authRepositoryProvider),
    tokenRepository: ref.watch(tokenRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final signInWithGoogleCommandProvider =
    Provider<SignInWithGoogleCommand>((ref) {
  return SignInWithGoogleCommand(
    authRepository: ref.watch(authRepositoryProvider),
    tokenRepository: ref.watch(tokenRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final signInWithKakaoCommandProvider = Provider<SignInWithKakaoCommand>((ref) {
  return SignInWithKakaoCommand(
    authRepository: ref.watch(authRepositoryProvider),
    tokenRepository: ref.watch(tokenRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final signInWithNaverCommandProvider = Provider<SignInWithNaverCommand>((ref) {
  return SignInWithNaverCommand(
    authRepository: ref.watch(authRepositoryProvider),
    tokenRepository: ref.watch(tokenRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final signOutCommandProvider = Provider<SignOutCommand>((ref) {
  return SignOutCommand(
    authRepository: ref.watch(authRepositoryProvider),
    tokenRepository: ref.watch(tokenRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final deregisterCommandProvider = Provider<DeregisterCommand>((ref) {
  return DeregisterCommand(
    tokenRepository: ref.watch(tokenRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final subscribeNotificationCommandProvider =
    Provider<SubscribeNotificationCommand>((ref) {
  return SubscribeNotificationCommand(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final unsubscribeNotificationCommandProvider =
    Provider<UnsubscribeNotificationCommand>((ref) {
  return UnsubscribeNotificationCommand(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final updateUserCommandProvider = Provider<UpdateUserCommand>((ref) {
  return UpdateUserCommand(
    userRepository: ref.watch(userRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final invokeOAuthCommandProvider = Provider<InvokeOAuthCommand>((ref) {
  return InvokeOAuthCommand(
    userRepository: ref.watch(userRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});

final revokeOAuthCommandProvider = Provider<RevokeOAuthCommand>((ref) {
  return RevokeOAuthCommand(
    userRepository: ref.watch(userRepositoryProvider),
    analytics: ref.watch(firebaseAnalyticsProvider),
  );
});
