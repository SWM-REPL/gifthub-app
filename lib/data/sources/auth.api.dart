// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth_token.dto.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<OAuthTokenDto> signIn({
    required final String username,
    required final String password,
  }) async {
    final response = await dio.post(
      '/auth/sign-in',
      data: {
        'username': username,
        'password': password,
      },
    );
    return OAuthTokenDto.fromJson(response.data);
  }

  Future<OAuthTokenDto> signInWithKakao(String kakaoAccessToken) async {
    final response = await dio.post(
      '/auth/sign-in/kakao',
      data: {
        'access_token': kakaoAccessToken,
      },
    );
    return OAuthTokenDto.fromJson(response.data);
  }

  Future<OAuthTokenDto> signInWithApple(String appleAuthToken) async {
    final response = await dio.post(
      '/auth/sign-in/apple',
      data: {
        'token': appleAuthToken,
      },
    );
    return OAuthTokenDto.fromJson(response.data);
  }

  Future<OAuthTokenDto> signUp({
    required final String nickname,
    required final String username,
    required final String password,
  }) async {
    final response = await dio.post(
      '/auth/sign-up',
      data: {
        'nickname': nickname,
        'username': username,
        'password': password,
      },
    );
    return OAuthTokenDto.fromJson(response.data);
  }

  Future<void> signOut() async {
    await dio.post('/auth/sign-out');
  }
}
