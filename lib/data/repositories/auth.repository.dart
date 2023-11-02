// 🌎 Project imports:
import 'package:gifthub/data/sources/auth.api.dart';
import 'package:gifthub/data/sources/auth.sdk.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final AuthSdk _authSdk;

  AuthRepositoryImpl({
    required AuthApi authApi,
    required AuthSdk authSdk,
  })  : _authApi = authApi,
        _authSdk = authSdk;

  @override
  Future<AuthToken> signInWithPassword({
    required final String username,
    required final String password,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final tokens = await _authApi.signIn(
      username: username,
      password: password,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signInWithKakao({
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final kakaoToken = await _authSdk.acquireOAuthToken('kakao');
    if (kakaoToken == null) {
      throw SignInException('카카오 로그인에 실패했습니다.');
    }

    final tokens = await _authApi.signInWithKakao(
      kakaoAccessToken: kakaoToken,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signInWithNaver({
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final naverToken = await _authSdk.acquireOAuthToken('naver');
    if (naverToken == null) {
      throw SignInException('사용자가 로그인을 취소했습니다.');
    }

    final tokens = await _authApi.signInWithNaver(
      naverAccessToken: naverToken,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signInWithGoogle({
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final googleToken = await _authSdk.acquireOAuthToken('google');
    if (googleToken == null) {
      throw SignInException('사용자가 로그인을 취소했습니다.');
    }

    final tokens = await _authApi.signInWithGoogle(
      googleAccessToken: googleToken,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signInWithApple({
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final appleToken = await _authSdk.acquireOAuthToken('apple');
    if (appleToken == null) {
      throw SignInException('애플 로그인에 실패했습니다.');
    }

    final tokens = await _authApi.signInWithApple(
      appleAccessToken: appleToken,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signUp({
    required final String nickname,
    required final String username,
    required final String password,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final tokens = await _authApi.signUp(
      nickname: nickname,
      username: username,
      password: password,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signUpWithRandom({
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final tokens = await _authApi.signUpWithRandom(
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }

  @override
  Future<void> signOut({
    required final String accessToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    await _authApi.signOut(
      accessToken: accessToken,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
  }

  @override
  Future<AuthToken> refreshAuthToken({
    required final String refreshToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final tokens = await _authApi.refreshAuthToken(
      refreshToken: refreshToken,
      deviceToken: deviceToken,
      fcmToken: fcmToken,
    );
    return tokens;
  }
}
