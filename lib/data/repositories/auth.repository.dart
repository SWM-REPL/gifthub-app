// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as apple;

// 🌎 Project imports:
import 'package:gifthub/data/sources/auth.api.dart';
import 'package:gifthub/data/sources/auth.storage.dart';
import 'package:gifthub/domain/entities/oauth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthStorage _authStorage;
  final AuthApi _authApi;

  AuthRepositoryImpl({
    required AuthStorage authStorage,
    required AuthApi authApi,
  })  : _authStorage = authStorage,
        _authApi = authApi;

  @override
  Future<OAuthToken?> loadFromStorage() async {
    return await _authStorage.loadOAuthToken();
  }

  @override
  Future<OAuthToken> signIn({
    required String username,
    required String password,
  }) async {
    final tokens = await _authApi.signIn(
      username: username,
      password: password,
    );
    _saveToStorage(tokens);
    return tokens;
  }

  @override
  Future<OAuthToken> signInWithKakao() async {
    late final kakao.OAuthToken? kakaoOauthToken;

    try {
      kakaoOauthToken = await kakao.UserApi.instance.loginWithKakaoTalk();
    } catch (error) {
      if (error is PlatformException && error.code == 'OPEN_URL_ERROR') {
        try {
          kakaoOauthToken =
              await kakao.UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          kakaoOauthToken = null;
          if (error is PlatformException) {
            showSnackBar(Text(error.message ?? '로그인에 실패했습니다.'));
          }
        }
      }
    }

    if (kakaoOauthToken == null) {
      throw SignInException('로그인에 실패했습니다.');
    }

    final tokens = await _authApi.signInWithKakao(kakaoOauthToken.accessToken);
    _saveToStorage(tokens);
    return tokens;
  }

  @override
  Future<OAuthToken> signInWithApple() async {
    final credential =
        await apple.SignInWithApple.getAppleIDCredential(scopes: [
      apple.AppleIDAuthorizationScopes.email,
      apple.AppleIDAuthorizationScopes.fullName,
    ]);
    final tokens = await _authApi.signInWithApple(credential.authorizationCode);
    _saveToStorage(tokens);
    return tokens;
  }

  @override
  Future<OAuthToken> signUp({
    required String nickname,
    required String username,
    required String password,
  }) async {
    final tokens = await _authApi.signUp(
      nickname: nickname,
      username: username,
      password: password,
    );
    _saveToStorage(tokens);
    return tokens;
  }

  @override
  Future<void> signOut() async {
    await _authApi.signOut();
    await _authStorage.deleteTokens();
  }

  Future<void> _saveToStorage(OAuthToken oauth) async {
    await _authStorage.saveOAuthTokens(oauth);
  }
}
