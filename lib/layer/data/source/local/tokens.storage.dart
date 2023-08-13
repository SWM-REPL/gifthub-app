// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';

const cachedTokenKey = 'CACHED_TOKEN_KEY';

mixin TokensStorageMixin {
  Future<void> saveTokens(Tokens token);
  Future<Tokens?> loadTokens();
  Future<void> deleteTokens();
}

class TokensStorage with TokensStorageMixin {
  TokensStorage({
    FlutterSecureStorage secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> saveTokens(Tokens token) async {
    final tokenJson = json.encode(token.toJson());
    await _secureStorage.write(key: key, value: tokenJson);
  }

  @override
  Future<Tokens?> loadTokens() async {
    final tokenJson = await _secureStorage.read(key: key);
    if (tokenJson == null) {
      return null;
    }
    return Tokens.fromJson(json.decode(tokenJson));
  }

  @override
  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: key);
  }

  @visibleForTesting
  static String get key => cachedTokenKey;
}
