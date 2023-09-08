// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/data/source/local/tokens.cache.dart';
import 'package:gifthub/layer/data/source/local/tokens.storage.dart';
import 'package:gifthub/layer/data/source/network/auth.api.dart';
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';
import 'package:gifthub/layer/domain/repository/tokens.repository.dart';

class TokensRepository with TokensRepositoryMixin {
  TokensRepository({
    required this.tokensCache,
    required this.tokensStorage,
    required this.authApi,
  });

  final TokensCacheMixin tokensCache;
  final TokensStorageMixin tokensStorage;
  final AuthApiMixin authApi;

  @override
  Future<void> saveTokens(Tokens tokens) async {
    tokensCache.saveTokens(tokens);
    await tokensStorage.saveTokens(tokens);
  }

  @override
  Future<void> deleteTokens() async {
    tokensCache.deleteTokens();
    await tokensStorage.deleteTokens();
  }

  @override
  Future<Tokens> loadTokens() async {
    if (tokensCache.isEmpty) {
      final tokens = await tokensStorage.loadTokens();
      tokensCache.saveTokens(tokens);
    }

    if (tokensCache.isEmpty == false && tokensCache.isStaled) {
      try {
        final tokens = await authApi.refreshTokens(tokensCache.refreshToken!);
        tokensStorage.saveTokens(tokens);
        tokensCache.saveTokens(tokens);
      } on DioException catch (e) {
        final data = e.response?.data as Map<String, dynamic>?;
        if (data != null && data['status_code'] == 401) {
          throw UnauthorizedException();
        }
      }
    }

    if (tokensCache.isExpired) {
      throw UnauthorizedException();
    }

    return tokensCache.tokens!;
  }
}
