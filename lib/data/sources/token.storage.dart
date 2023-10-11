// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth_token.dto.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';

class TokenStorage {
  static const _oauthTokenKey = 'OAUTH_TOKEN_KEY';
  static const _fcmTokenKey = 'DEVICE_TOKEN_KEY';

  final FlutterSecureStorage _secureStorage;

  AuthToken? _cachedAuthToken;
  String? _cachedFCMToken;

  TokenStorage(this._secureStorage)
      : _cachedAuthToken = null,
        _cachedFCMToken = null;

  Future<void> saveAuthToken(AuthToken oauth) async {
    _cachedAuthToken = oauth;

    final tokenJson = json.encode(AuthTokenDto.from(oauth).toJson());
    await _secureStorage.write(key: _oauthTokenKey, value: tokenJson);
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
    _cachedAuthToken = null;
    await _secureStorage.delete(key: _oauthTokenKey);
  }

  Future<void> saveFCMToken(String deviceToken) async {
    _cachedFCMToken = deviceToken;
    await _secureStorage.write(key: _fcmTokenKey, value: deviceToken);
  }

  Future<String?> getFCMToken() async {
    if (_cachedFCMToken != null) {
      return _cachedFCMToken;
    }

    final fcmToken = await _secureStorage.read(key: _fcmTokenKey);
    if (fcmToken != null) {
      return fcmToken;
    }

    final newToken = await issueFCMToken();
    if (newToken != null) {
      await saveFCMToken(newToken);
      return newToken;
    }

    return null;
  }

  Future<void> deleteFCMToken() async {
    _cachedFCMToken = null;
    await _secureStorage.delete(key: _fcmTokenKey);
  }

  Future<String?> issueFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
