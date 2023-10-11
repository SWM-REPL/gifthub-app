// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth_token.dto.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<AuthTokenDto> signIn({
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
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithKakao(String kakaoAccessToken) async {
    final response = await dio.post(
      '/auth/sign-in/kakao',
      data: {
        'access_token': kakaoAccessToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithApple(String appleAccessToken) async {
    final response = await dio.post(
      '/auth/sign-in/apple',
      data: {
        'token': appleAccessToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithNaver(String naverAccessToken) async {
    final response = await dio.post(
      '/auth/sign-in/naver',
      data: {'token': naverAccessToken},
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithGoogle(String googleAccessToken) async {
    final response = await dio.post(
      '/auth/sign-in/google',
      data: {'token': googleAccessToken},
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signUp({
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
    return AuthTokenDto.fromJson(response.data);
  }

  Future<void> signOut() async {
    await dio.post('/auth/sign-out');
  }
}
