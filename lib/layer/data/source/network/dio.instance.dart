// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/data/source/local/token.cache.dart';
import 'package:gifthub/layer/data/source/local/token.storage.dart';
import 'package:gifthub/layer/data/source/network/token.api.dart';

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
  static final SingleDio storage = SingleDio._('storage');

  final Dio _dio;
  Dio get dio => _dio;
}

class _TokenInterceptor extends Interceptor {
  _TokenInterceptor({
    TokenCacheMixin? tokenCache,
    TokenStorageMixin? tokenStorage,
    TokenApi? tokenApi,
  })  : _tokenCache = tokenCache ?? TokenCache.instance,
        _tokenStorage = tokenStorage ?? TokenStorage(),
        _tokenApi = tokenApi ?? TokenApi();

  final TokenCacheMixin _tokenCache;
  final TokenStorageMixin _tokenStorage;
  final TokenApi _tokenApi;

  @override
  Future<void> onRequest(options, handler) async {
    if (options.headers.containsKey('no-auth')) {
      options.headers.remove('no-auth');
      return handler.next(options);
    }

    // If token is empty, load token from storage if possible.
    if (_tokenCache.isEmpty) {
      _tokenCache.token = await _tokenStorage.loadToken();
    }

    // If token is expired, refresh token if possible.
    if (!_tokenCache.isEmpty && _tokenCache.isExpired) {
      try {
        _tokenCache.token =
            await _tokenApi.refresh(token: _tokenCache.refreshToken!);
      } catch (_) {
        _tokenCache.token = null;
      }
    }

    // If token is still empty or expired, throw exception.
    if (_tokenCache.isExpired) {
      return handler.reject(UnauthorizedException(requestOptions: options));
    }

    options.headers['Authorization'] = 'Bearer ${_tokenCache.accessToken}';
    return handler.next(options);
  }

  @override
  Future<void> onResponse(options, handler) async {
    if (options.statusCode == 200) {
      options.data = options.data['data'];
    }
    return handler.next(options);
  }
}

mixin DioMixin {
  final Dio _dio = SingleDio.api.dio;
  Dio get dio => _dio;
}
