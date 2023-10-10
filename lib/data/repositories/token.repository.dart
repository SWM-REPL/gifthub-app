// 🌎 Project imports:
import 'package:gifthub/data/sources/token.storage.dart';
import 'package:gifthub/domain/entities/oauth_token.entity.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenStorage _tokenStorage;

  TokenRepositoryImpl({
    required final TokenStorage tokenStorage,
  }) : _tokenStorage = tokenStorage;

  @override
  Future<void> saveOAuthToken(OAuthToken token) async {
    return await _tokenStorage.saveOAuthToken(token);
  }

  @override
  Future<void> deleteOAuthToken() async {
    return await _tokenStorage.deleteOAuthToken();
  }

  @override
  Future<OAuthToken?> getOAuthToken() async {
    return await _tokenStorage.getOAuthToken();
  }

  @override
  Future<void> saveFCMToken(String token) async {
    return await _tokenStorage.saveFCMToken(token);
  }

  @override
  Future<void> deleteFCMToken() async {
    return await _tokenStorage.deleteFCMToken();
  }

  @override
  Future<String?> getFCMToken() async {
    return await _tokenStorage.getFCMToken();
  }

  @override
  Future<void> deleteAll() async {
    await _tokenStorage.deleteOAuthToken();
    await _tokenStorage.deleteFCMToken();
  }
}
