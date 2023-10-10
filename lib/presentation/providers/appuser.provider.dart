// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/appuser.entity.dart';
import 'package:gifthub/domain/entities/oauth_token.entity.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

class AppUserProvider extends AsyncNotifier<AppUser?> {
  AuthRepository get _authRepository => ref.watch(authRepositoryProvider);
  UserRepository get _userRepository => ref.watch(userRepositoryProvider);

  @override
  Future<AppUser?> build() async {
    return await _fetch();
  }

  void signIn(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final oauth = await _authRepository.signInWithPassword(
        username: username,
        password: password,
      );
      ref.watch(oauthTokenProvider.notifier).state = oauth;
      return null;
    });
  }

  void signInWithKakao() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final oauth = await _authRepository.signInWithKakao();
      ref.watch(oauthTokenProvider.notifier).state = oauth;
      return null;
    });
  }

  void signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final oauth = await _authRepository.signInWithApple();
      ref.watch(oauthTokenProvider.notifier).state = oauth;
      return null;
    });
  }

  void signUp(
    String username,
    String password,
    String nickname,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final oauth = await _authRepository.signUp(
        username: username,
        password: password,
        nickname: nickname,
      );
      ref.watch(oauthTokenProvider.notifier).state = oauth;
      final me = await _userRepository.getUser(oauth.userId);
      return AppUser.from(me, oauth);
    });
  }

  void subscribeNotification(String fcmToken) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final notiRepository = ref.watch(notificationRepositoryProvider);
      await notiRepository.subscribeNotification(fcmToken);
      return _fetch();
    });
  }

  Future<AppUser?> _fetch() async {
    final oauthToken = await _loadOAuthToken();
    if (oauthToken == null) {
      return null;
    }
    try {
      final me = await _userRepository.getUser(oauthToken.userId);
      return AppUser.from(me, oauthToken);
    } catch (e) {
      return null;
    }
  }

  Future<OAuthToken?> _loadOAuthToken() async {
    final oauthToken = ref.watch(oauthTokenProvider);
    if (oauthToken != null) {
      return oauthToken;
    }

    final tokenRepository = ref.watch(tokenRepositoryProvider);
    final oauthFromStorage = await tokenRepository.getOAuthToken();
    if (oauthFromStorage != null) {
      ref.watch(oauthTokenProvider.notifier).state = oauthFromStorage;
      return oauthFromStorage;
    }

    return null;
  }
}

final appUserProvider =
    AsyncNotifierProvider<AppUserProvider, AppUser?>(() => AppUserProvider());
