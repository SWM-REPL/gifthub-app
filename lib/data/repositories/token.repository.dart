// 🌎 Project imports:
import 'package:gifthub/data/sources/token.storage.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenStorage _tokenStorage;

  TokenRepositoryImpl({
    required final TokenStorage tokenStorage,
  }) : _tokenStorage = tokenStorage;

  @override
  Future<void> saveAuthToken(AuthToken token) async {
    return await _tokenStorage.saveAuthToken(token);
  }

  @override
  Future<void> deleteAuthToken() async {
    return await _tokenStorage.deleteAuthToken();
  }

  @override
  Future<AuthToken?> getAuthToken() async {
    return await _tokenStorage.getAuthToken();
  }
}
