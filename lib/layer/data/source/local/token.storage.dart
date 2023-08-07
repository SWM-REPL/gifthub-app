import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:gifthub/layer/data/dto/token.dto.dart';

const cachedTokenKey = 'CACHED_TOKEN_KEY';

mixin TokenStorageMixin {
  Future<void> saveToken({required TokenDto token});
  Future<TokenDto?> loadToken();
  Future<void> deleteToken();
}

class TokenStorage with TokenStorageMixin {
  TokenStorage({
    FlutterSecureStorage secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> saveToken({required TokenDto token}) async {
    final tokenJson = json.encode(token.toJson());
    await _secureStorage.write(key: key, value: tokenJson);
  }

  @override
  Future<TokenDto?> loadToken() async {
    final tokenJson = await _secureStorage.read(key: key);
    if (tokenJson == null) {
      return null;
    }
    return TokenDto.fromJson(json.decode(tokenJson));
  }

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: key);
  }

  @visibleForTesting
  static String get key => cachedTokenKey;
}
