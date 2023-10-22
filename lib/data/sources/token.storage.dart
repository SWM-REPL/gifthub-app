// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth_token.dto.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';

class TokenStorage {
  static const _oauthTokenKey = 'OAUTH_TOKEN_KEY';

  final FlutterSecureStorage _secureStorage;

  AuthToken? _cachedAuthToken;

  TokenStorage(this._secureStorage) : _cachedAuthToken = null;

  Future<void> saveAuthToken(AuthToken oauth) async {
    final tokenJson = json.encode(AuthTokenDto.from(oauth).toJson());
    await _secureStorage.write(
      key: _oauthTokenKey,
      value: tokenJson,
    );

    _cachedAuthToken = oauth;
  }

  Future<AuthToken?> getAuthToken() async {
    if (_cachedAuthToken != null) {
      return _cachedAuthToken;
    }

    final tokenJson = await _secureStorage.read(key: _oauthTokenKey);
    return tokenJson != null
        ? AuthTokenDto.fromJson(json.decode(tokenJson))
        : null;
  }

  Future<void> deleteAuthToken() async {
    await _secureStorage.delete(key: _oauthTokenKey);

    _cachedAuthToken = null;
  }
}
