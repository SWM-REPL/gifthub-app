// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth_token.dto.dart';
import 'package:gifthub/domain/entities/oauth_token.entity.dart';

class AuthStorage {
  static const _cachedTokenKey = 'CACHED_TOKEN_KEY';

  final FlutterSecureStorage _secureStorage;

  AuthStorage(this._secureStorage);

  Future<void> saveOAuthTokens(OAuthToken oauth) async {
    final tokenJson = json.encode(OAuthTokenDto.from(oauth).toJson());
    await _secureStorage.write(key: _cachedTokenKey, value: tokenJson);
  }

  Future<OAuthToken?> loadOAuthToken() async {
    final tokenJson = await _secureStorage.read(key: _cachedTokenKey);
    if (tokenJson == null) {
      return null;
    }
    return OAuthTokenDto.fromJson(json.decode(tokenJson));
  }

  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: _cachedTokenKey);
  }
}
