// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth_token.dto.dart';

class AuthApi {
  late final Dio dio;

  AuthApi({
    required String host,
    required String userAgent,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: host,
        headers: {
          'User-Agent': 'GiftHub/0.4.0',
          'Content-Type': 'application/json'
        },
      ),
    )..interceptors.add(
        InterceptorsWrapper(
          onResponse: (response, handler) {
            if (response.statusCode == 200) {
              final data = response.data as Map<String, dynamic>?;
              if (data != null && data.containsKey('data')) {
                response.data = data['data'];
              }
            }
            return handler.next(response);
          },
        ),
      );
  }

  Future<AuthTokenDto> signIn({
    required final String username,
    required final String password,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/sign-in',
      data: {
        'username': username,
        'password': password,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithKakao({
    required final String kakaoAccessToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/sign-in/kakao',
      data: {
        'token': kakaoAccessToken,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithApple({
    required final String appleAccessToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/sign-in/apple',
      data: {
        'token': appleAccessToken,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithNaver({
    required final String naverAccessToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/sign-in/naver',
      data: {
        'token': naverAccessToken,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signInWithGoogle({
    required final String googleAccessToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/sign-in/google',
      data: {
        'token': googleAccessToken,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<AuthTokenDto> signUp({
    required final String nickname,
    required final String username,
    required final String password,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/sign-up',
      data: {
        'nickname': nickname,
        'username': username,
        'password': password,
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }

  Future<void> signOut({
    required final String accessToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    await dio.post(
      '/auth/sign-out',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: {
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
  }

  Future<AuthTokenDto> refreshAuthToken({
    required final String refreshToken,
    required final String deviceToken,
    final String? fcmToken,
  }) async {
    final response = await dio.post(
      '/auth/refresh',
      options: Options(headers: {
        'Authorization': 'Bearer $refreshToken',
      }),
      data: {
        'device_token': deviceToken,
        'fcm_token': fcmToken,
      },
    );
    return AuthTokenDto.fromJson(response.data);
  }
}
