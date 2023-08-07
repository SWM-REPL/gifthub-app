import 'package:gifthub/layer/data/dto/token.dto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

mixin TokenCacheMixin {
  String? get accessToken;
  String? get refreshToken;
  bool get isEmpty;
  bool get isExpired;

  set token(TokenDto? token);
}

class TokenCache with TokenCacheMixin {
  TokenCache._();
  static final TokenCache instance = TokenCache._();

  TokenDto? _token;

  @override
  String? get accessToken {
    if (_token == null || JwtDecoder.isExpired(_token!.accessToken)) {
      return null;
    }
    return _token!.accessToken;
  }

  @override
  String? get refreshToken {
    if (_token == null || JwtDecoder.isExpired(_token!.refreshToken)) {
      return null;
    }
    return _token!.refreshToken;
  }

  @override
  set token(TokenDto? token) {
    _token = token;
  }

  @override
  bool get isEmpty => _token == null;

  @override
  bool get isExpired =>
      _token == null || JwtDecoder.isExpired(_token!.accessToken);
}
