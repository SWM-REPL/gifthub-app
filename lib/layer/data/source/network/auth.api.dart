// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/tokens.dto.dart';

mixin AuthApiMixin {
  Future<TokensDto> signin({
    required String username,
    required String password,
  });
  Future<TokensDto> signup({
    required String username,
    required String password,
    required String nickname,
  });
  Future<TokensDto> refreshTokens(
    String token,
  );
}

class AuthApi with AuthApiMixin {
  AuthApi({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = 'https://api.gifthub.kr';
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (options, handler) async {
          options.data = options.data['data'];
          return handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  final Dio _dio;

  @override
  Future<TokensDto> signin({
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
    return TokensDto.fromJson(response.data);
  }

  @override
  Future<TokensDto> signup({
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
    return TokensDto.fromJson(response.data);
  }

  @override
  Future<TokensDto> refreshTokens(String token) async {
    const String endpoint = '/auth/refresh';

    final response = await _dio.post(
      endpoint,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return TokensDto.fromJson(response.data);
  }
}
