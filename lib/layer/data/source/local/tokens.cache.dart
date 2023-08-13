// 📦 Package imports:
import 'package:jwt_decoder/jwt_decoder.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';

mixin TokensCacheMixin {
  Tokens? get tokens;
  String? get accessToken;
  String? get refreshToken;
  bool get isEmpty;
  bool get isStaled;
  bool get isExpired;

  void saveTokens(Tokens? tokens);
  void deleteTokens();
}

class TokensCache with TokensCacheMixin {
  TokensCache() : _data = null;

  Tokens? _data;

  @override
  Tokens? get tokens => _data;

  @override
  String? get accessToken {
    if (_data == null || JwtDecoder.isExpired(_data!.accessToken)) {
      return null;
    }
    return _data!.accessToken;
  }

  @override
  String? get refreshToken {
    if (_data == null || JwtDecoder.isExpired(_data!.refreshToken)) {
      return null;
    }
    return _data!.refreshToken;
  }

  @override
  void saveTokens(Tokens? tokens) {
    _data = tokens;
  }

  @override
  void deleteTokens() {
    _data = null;
  }

  @override
  bool get isEmpty => _data == null;

  @override
  bool get isStaled =>
      _data == null || JwtDecoder.isExpired(_data!.accessToken);

  @override
  bool get isExpired =>
      _data == null || JwtDecoder.isExpired(_data!.refreshToken);
}
