// 🌎 Project imports:
import 'package:gifthub/data/sources/token.sdk.dart';
import 'package:gifthub/data/sources/token.storage.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenStorage _tokenStorage;
  final TokenSdk _tokenSdk;

  TokenRepositoryImpl({
    required final TokenStorage tokenStorage,
    required final TokenSdk tokenSdk,
  })  : _tokenStorage = tokenStorage,
        _tokenSdk = tokenSdk;

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

  @override
  Future<String?> getFcmToken() async {
    return await _tokenSdk.acquireFcmToken();
  }

  @override
  Future<String> getDeviceToken() async {
    return await _tokenStorage.getDeviceToken();
  }
}
