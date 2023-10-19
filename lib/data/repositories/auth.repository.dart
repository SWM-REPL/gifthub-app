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
  }) async {
    final tokens = await _authApi.signIn(
      username: username,
      password: password,
    );
    return tokens;
  }

  @override
  Future<AuthToken> signInWithKakao() async {
    final kakaoToken = await _authSdk.acquireKakaoToken();
    if (kakaoToken == null) {
      throw SignInException('카카오 로그인에 실패했습니다.');
    }

    final tokens = await _authApi.signInWithKakao(kakaoToken);
    return tokens;
  }

  @override
  Future<AuthToken> signInWithApple() async {
    final appleToken = await _authSdk.acquireAppleToken();
    if (appleToken == null) {
      throw SignInException('애플 로그인에 실패했습니다.');
    }

    final tokens = await _authApi.signInWithApple(appleToken);
    return tokens;
  }

  @override
  Future<AuthToken> signInWithNaver() async {
    final naverToken = await _authSdk.acquireNaverToken();
    if (naverToken == null) {
      throw SignInException('사용자가 로그인을 취소했습니다.');
    }

    final tokens = await _authApi.signInWithNaver(naverToken);
    return tokens;
  }

  @override
  Future<AuthToken> signInWithGoogle() async {
    final googleToken = await _authSdk.acquireGoogleToken();
    if (googleToken == null) {
      throw SignInException('사용자가 로그인을 취소했습니다.');
    }

    final tokens = await _authApi.signInWithGoogle(googleToken);
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
