import 'package:dio/dio.dart';

import 'package:gifthub/layer/data/dto/token.dto.dart';

mixin TokenApiMixin {
  Future<TokenDto> signin({
    required String username,
    required String password,
  });
  Future<TokenDto> signup({
    required String username,
    required String password,
    required String nickname,
  });
  Future<TokenDto> refresh({
    required String token,
  });
}

class TokenApi with TokenApiMixin {
  TokenApi({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = 'https://api.gifthub.kr';
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  final Dio _dio;

  @override
  Future<TokenDto> signin({
    required String username,
    required String password,
  }) async {
    const String endpoint = '/auth/sign-in';

    final response = await _dio.post(
      endpoint,
      data: {
        'username': username,
        'password': password,
      },
    );
    return TokenDto.fromJson(response.data);
  }

  @override
  Future<TokenDto> signup({
    required String username,
    required String password,
    required String nickname,
  }) async {
    const String endpoint = '/auth/sign-up';

    final response = await _dio.post(
      endpoint,
      data: {
        'username': username,
        'password': password,
        'nickname': nickname,
      },
    );
    return TokenDto.fromJson(response.data);
  }

  @override
  Future<TokenDto> refresh({
    required String token,
  }) async {
    const String endpoint = '/auth/refresh';

    final response = await _dio.post(
      endpoint,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return TokenDto.fromJson(response.data);
  }
}
