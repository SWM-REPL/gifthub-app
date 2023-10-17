// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as apple;

// 🌎 Project imports:
import 'package:gifthub/data/sources/auth.api.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl({
    required AuthApi authApi,
  }) : _authApi = authApi;

  @override
  Future<AuthToken> signInWithPassword({
    required final String username,
    required final String password,
  }) async {
    final tokens = await _authApi.signIn(
      username: username,
      password: password,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signInWithKakao() async {
    late final kakao.OAuthToken? kakaoOauthToken;

    try {
      kakaoOauthToken = await kakao.UserApi.instance.loginWithKakaoTalk();
    } catch (error) {
      if (error is PlatformException &&
          (error.code == 'OPEN_URL_ERROR' || error.code == 'Error')) {
        try {
          kakaoOauthToken =
              await kakao.UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          kakaoOauthToken = null;
          if (error is PlatformException) {
            throw SignInException(error.message ?? '로그인에 실패했습니다.');
          }
        }
      }
    }

    if (kakaoOauthToken == null) {
      throw SignInException('로그인에 실패했습니다.');
    }

    final tokens = await _authApi.signInWithKakao(kakaoOauthToken.accessToken);
    return tokens;
  }

  @override
  Future<AuthToken> signInWithApple() async {
    if (!Platform.isIOS) {
      throw Exception('iOS에서만 사용할 수 있습니다.');
    }
    try {
      final credential = await apple.SignInWithApple.getAppleIDCredential(
        scopes: [
          apple.AppleIDAuthorizationScopes.email,
          apple.AppleIDAuthorizationScopes.fullName,
        ],
      );
      final tokens =
          await _authApi.signInWithApple(credential.authorizationCode);
      return tokens;
    } catch (exception) {
      if (exception is apple.SignInWithAppleAuthorizationException) {
        throw SignInException(exception.message);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<AuthToken> signInWithNaver() async {
    await FlutterNaverLogin.logIn();
    final naverToken = await FlutterNaverLogin.currentAccessToken;
    final tokens = await _authApi.signInWithNaver(naverToken.accessToken);
    return tokens;
  }

  @override
  Future<AuthToken> signInWithGoogle() async {
    final google = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
    final credential = await google.signIn();
    final googleTokens = await credential?.authentication;
    if (googleTokens == null) {
      throw SignInException('사용자가 로그인을 취소했습니다.');
    }
    final tokens = await _authApi.signInWithGoogle(googleTokens.idToken!);
    return tokens;
  }

  @override
  Future<AuthToken> signUp({
    required final String nickname,
    required final String username,
    required final String password,
  }) async {
    final tokens = await _authApi.signUp(
      nickname: nickname,
      username: username,
      password: password,
    );
    return tokens;
  }

  @override
  Future<void> signOut() async {
    await _authApi.signOut();
  }
}
