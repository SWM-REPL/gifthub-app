import 'package:dio/dio.dart';
import 'package:gifthub/exceptions/unauthorized.exception.dart';
import 'package:gifthub/apis/url.dart';

import '../providers/token.provider.dart';

class AuthService {
  static final dio = Dio();

  static Future<Tokens> signin({
    required String username,
    required String password,
  }) async {
    final body = {
      'username': username,
      'password': password,
    };

    try {
      final response = await dio.post(ApiUrl.signin, data: body);
      return Tokens.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final body = e.response?.data;
        return Future.error(Exception(body['message']));
      }
      rethrow;
    }
  }

  static Future<Tokens> signup({
    required String username,
    required String password,
    required String nickname,
  }) async {
    final body = {
      'username': username,
      'password': password,
      'nickname': nickname,
    };

    try {
      final response = await dio.post(
        ApiUrl.signup,
        data: body,
      );
      return Tokens.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final body = e.response?.data;
        return Future.error(Exception(body['message']));
      }
      rethrow;
    }
  }

  static Future<bool> signout(String refreshToken) async {
    try {
      final response = await dio.post(
        ApiUrl.signout,
        options: Options(headers: {
          'Authorization': 'Bearer $refreshToken',
        }),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final body = e.response?.data;
        return Future.error(Exception(body['message']));
      }
      rethrow;
    }
  }

  static Future<Tokens> refresh(String refreshToken) async {
    try {
      final response = await dio.post(
        ApiUrl.refresh,
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
      return Tokens.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      rethrow;
    }
  }
}
