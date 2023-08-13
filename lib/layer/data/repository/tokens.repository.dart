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
  Future<void> deleteTokens() async {}

  @override
  Future<Tokens> loadTokens() async {
    if (tokensCache.isEmpty) {
      tokensCache.saveTokens(await tokensStorage.loadTokens());
    }

    if (tokensCache.isEmpty == false && tokensCache.isStaled) {
      tokensCache
          .saveTokens(await authApi.refreshTokens(tokensCache.refreshToken!));
    }

    if (tokensCache.isExpired) {
      throw UnauthorizedException();
    }

    return tokensCache.tokens!;
  }
}
