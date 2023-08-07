import 'package:gifthub/layer/data/dto/token.dto.dart';
import 'package:gifthub/layer/data/source/local/token.storage.dart';
import 'package:gifthub/layer/data/source/network/token.api.dart';
import 'package:gifthub/layer/domain/repository/token.repository.dart';

class TokenRepository with TokenRepositoryMixin {
  TokenRepository({
    required TokenApiMixin api,
    required TokenStorageMixin storage,
  })  : _api = api,
        _storage = storage;

  final TokenApiMixin _api;
  final TokenStorageMixin _storage;

  Future<TokenDto?> get token => _storage.loadToken();

  @override
  Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final token = await _api.signin(
        username: username,
        password: password,
      );
      await _storage.saveToken(token: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signUp({
    required String username,
    required String password,
    required String nickname,
  }) async {
    try {
      final token = await _api.signup(
        username: username,
        password: password,
        nickname: nickname,
      );
      await _storage.saveToken(token: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _storage.deleteToken();
      return true;
    } catch (e) {
      return false;
    }
  }
}
