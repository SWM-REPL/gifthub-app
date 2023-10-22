// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in.view.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.view.dart';
import 'package:gifthub/utility/navigator.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () async {
      final tokenLoaded = await loadAuthToken(ref);

      if (tokenLoaded) {
        navigate(const VoucherListView(), clearStack: true);
      } else {
        navigate(const SignInView(), clearStack: true);
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

    final token = await tokenRepository.getAuthToken();
    if (token != null && !token.isExpired) {
      final newToken = await authRepository.refreshAuthToken(
        token.refreshToken,
      );
      await tokenRepository.saveAuthToken(newToken);
      authTokenNotifier.state = newToken;
      return true;
    }
    return false;
  }
}
