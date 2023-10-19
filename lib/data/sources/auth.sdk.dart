// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthSdk {
  Future<String?> acquireKakaoToken() async {
    try {
      final oauthToken = await UserApi.instance.loginWithKakaoTalk();
      return oauthToken.accessToken;
    } catch (error) {
      if (error is! PlatformException) {
        rethrow;
      }
      final oauthToken = await UserApi.instance.loginWithKakaoAccount();
      return oauthToken.accessToken;
    }
  }

  Future<String?> acquireAppleToken() async {
    try {
      final appleToken = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      return appleToken.identityToken;
    } catch (exception) {
      if (exception is SignInWithAppleAuthorizationException) {
        return null;
      }
      rethrow;
    }
  }

  Future<String?> acquireNaverToken() async {
    try {
      await FlutterNaverLogin.logIn();
      final currentToken = await FlutterNaverLogin.currentAccessToken;
      return currentToken.accessToken;
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> acquireGoogleToken() async {
    try {
      final google = GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );
      final credential = await google.signIn();
      final googleTokens = await credential?.authentication;
      return googleTokens?.accessToken;
    } catch (error) {
      rethrow;
    }
  }
}
