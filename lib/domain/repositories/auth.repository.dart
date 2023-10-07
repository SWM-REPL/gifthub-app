// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth_token.entity.dart';

abstract class AuthRepository {
  Future<OAuthToken?> loadFromStorage();

  Future<OAuthToken> signIn({
    required String username,
    required String password,
  });

  Future<OAuthToken> signInWithKakao();

  Future<OAuthToken> signInWithApple();

  Future<OAuthToken> signUp({
    required String nickname,
    required String username,
    required String password,
  });

  Future<void> signOut();
}
