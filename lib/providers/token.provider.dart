import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:gifthub/apis/auth.api.dart';
import 'package:gifthub/exceptions/unauthorized.exception.dart';

@immutable
class Tokens {
  final String accessToken;
  final String refreshToken;

  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  Tokens.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'];

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tokens &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}

class TokensNotifier extends AsyncNotifier<Tokens> {
  static const tokensKey = 'tokens';
  static const _storage = FlutterSecureStorage();

  @override
  Future<Tokens> build() async {
    final tokensJson = await _storage.read(key: tokensKey);

    if (tokensJson == null) {
      throw UnauthorizedException();
    }

    return Tokens.fromJson(json.decode(tokensJson));
  }

  Future<void> authenticate({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _storage.delete(key: tokensKey);

      final tokens = await AuthService.signin(
        username: username,
        password: password,
      );
      await _storage.write(
        key: tokensKey,
        value: json.encode(tokens.toJson()),
      );
      return tokens;
    });
  }

  Future<void> register({
    required String username,
    required String password,
    required String passwordCheck,
    required String nickname,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _storage.delete(key: tokensKey);
      final tokens = await AuthService.signup(
        username: username,
        password: password,
        nickname: nickname,
      );
      await _storage.write(
        key: tokensKey,
        value: json.encode(tokens.toJson()),
      );
      return tokens;
    });
  }

  Future<void> refresh() async {
    final refreshToken = state.value?.refreshToken;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (refreshToken == null) {
        throw UnauthorizedException();
      }
      await _storage.delete(key: tokensKey);
      final tokens = await AuthService.refresh(refreshToken);
      await _storage.write(
        key: tokensKey,
        value: json.encode(tokens.toJson()),
      );
      return tokens;
    });
  }

  Future<void> signout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final refreshToken = state.value?.refreshToken;
      if (refreshToken == null) {
        throw UnauthorizedException();
      }

      await _storage.delete(key: tokensKey);
      await AuthService.signout(refreshToken);
      throw UnauthorizedException();
    });
  }
}

final tokensNotifierProvider =
    AsyncNotifierProvider<TokensNotifier, Tokens>(() => TokensNotifier());
