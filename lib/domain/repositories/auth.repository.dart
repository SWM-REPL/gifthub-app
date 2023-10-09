// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth_token.entity.dart';

abstract class AuthRepository {
  Future<OAuthToken?> loadFromStorage();

  Future<OAuthToken> signIn({
    required final String username,
    required final String password,
  });

  Future<OAuthToken> signInWithKakao();

  Future<OAuthToken> signInWithApple();

  Future<OAuthToken> signUp({
    required final String nickname,
    required final String username,
    required final String password,
  });

  Future<void> signOut({required final String deviceToken});
}
