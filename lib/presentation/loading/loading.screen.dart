// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/home/home.screen.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in.screen.dart';
import 'package:gifthub/utility/navigator.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () async {
      final isTokenLoaded = await loadAuthToken(ref);
      if (isTokenLoaded) {
        await ref.watch(appUserProvider.future);
        ref.invalidate(voucherIdsProvider);
        navigate(const HomeScreen(), clearStack: true);
      } else {
        navigate(const SignInScreen(), clearStack: true);
      }
    });
    return Scaffold(
      body: _buildIntro(),
    );
  }

  Widget _buildIntro() {
    return const Loading();
  }

  Future<bool> loadAuthToken(WidgetRef ref) async {
    final authTokenNotifier = ref.watch(authTokenProvider.notifier);
    final authRepository = ref.watch(authRepositoryProvider);
    final tokenRepository = ref.watch(tokenRepositoryProvider);

    final token =
        authTokenNotifier.state ?? await tokenRepository.getAuthToken();
    if (token == null) {
      return false;
    }

    if (!token.isStaled) {
      authTokenNotifier.state = token;
    } else if (!token.isExpired) {
      try {
        final newToken = await authRepository.refreshAuthToken(
          refreshToken: token.refreshToken,
          deviceToken: await tokenRepository.getDeviceToken(),
          fcmToken: await tokenRepository.getFcmToken(),
        );
        await tokenRepository.saveAuthToken(newToken);
        authTokenNotifier.state = newToken;
      } on UnauthorizedException {
        return false;
      }
    }

    return true;
  }
}
