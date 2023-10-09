// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in.view.dart';
import 'package:gifthub/utility/navigator.dart';

class ExceptionBoundary extends ConsumerWidget {
  final Widget child;

  const ExceptionBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final next = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exception is UnauthorizedException) {
        ref.watch(oauthTokenProvider.notifier).state = null;
        ref.watch(authStorageProvider).deleteOAuthToken();
        ref.watch(notificationStorageProvider).deleteDeviceToken();
        navigate(const SignInView(), clearStack: true);
      } else {
        next?.call(details);
      }
    };
    return child;
  }
}
