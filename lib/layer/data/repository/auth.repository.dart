// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/auth.api.dart';
import 'package:gifthub/layer/domain/repository/auth.repository.dart';
import 'package:gifthub/layer/domain/repository/tokens.repository.dart';

class AuthRepository with AuthRepositoryMixin {
  AuthRepository({
    required this.authApi,
    required this.tokensRepository,
  });

  final AuthApiMixin authApi;
  final TokensRepositoryMixin tokensRepository;

  @override
  Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final token = await authApi.signin(
        username: username,
        password: password,
      );
      await tokensRepository.saveTokens(token);
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
      final token = await authApi.signup(
        username: username,
        password: password,
        nickname: nickname,
      );
      await tokensRepository.saveTokens(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final tokens = await tokensRepository.loadTokens();
      if (tokens != null) {
        await tokensRepository.deleteTokens();
        await authApi.signout(tokens.accessToken);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
