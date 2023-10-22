// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';

abstract class AuthRepository {
  Future<AuthToken> signInWithPassword({
    required final String username,
    required final String password,
  });

  Future<AuthToken> signInWithKakao();

  Future<AuthToken> signInWithApple();

  Future<AuthToken> signInWithNaver();

  Future<AuthToken> signInWithGoogle();

  Future<AuthToken> signUp({
    required final String nickname,
    required final String username,
    required final String password,
  });

  Future<void> signOut();

  Future<AuthToken> refreshAuthToken(final String refreshToken);
}
