// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/tokens.repository.dart';
import 'package:gifthub/layer/data/source/network/auth.api.dart';
import 'package:gifthub/layer/domain/repository/tokens.repository.dart';
import 'package:gifthub/main.dart';

class SingleDio {
  SingleDio._(String subdomain) : _dio = Dio() {
    _dio.options.baseUrl = 'https://$subdomain.gifthub.kr';
    _dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer',
    };
    _dio.interceptors.add(_TokenInterceptor());
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
  static final SingleDio api = SingleDio._('api');

  final Dio _dio;
  Dio get dio => _dio;
}

class _TokenInterceptor extends Interceptor {
  _TokenInterceptor();

  final TokensRepositoryMixin _tokensRepository = TokensRepository(
    tokensCache: tokensCache,
    tokensStorage: tokensStorage,
    authApi: AuthApi(),
  );

  @override
  Future<void> onRequest(options, handler) async {
    if (options.headers.containsKey('no-auth')) {
      options.headers.remove('no-auth');
      return handler.next(options);
    }

    final tokens = await _tokensRepository.loadTokens();
    options.headers['Authorization'] = 'Bearer ${tokens?.accessToken}';
    return handler.next(options);
  }

  @override
  Future<void> onResponse(options, handler) async {
    if (options.statusCode == 200) {
      final data = options.data as Map<String, dynamic>?;
      if (data != null && data.containsKey('data')) {
        options.data = data['data'];
      }
    }
    return handler.next(options);
  }
}

mixin DioMixin {
  final Dio _dio = SingleDio.api.dio;
  Dio get dio => _dio;
}
