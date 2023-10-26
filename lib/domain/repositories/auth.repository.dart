// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';

abstract class AuthRepository {
  Future<AuthToken> signInWithPassword({
    required final String username,
    required final String password,
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<AuthToken> signInWithKakao({
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<AuthToken> signInWithApple({
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<AuthToken> signInWithNaver({
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<AuthToken> signInWithGoogle({
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<AuthToken> signUp({
    required final String nickname,
    required final String username,
    required final String password,
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<void> signOut({
    required final String deviceToken,
    final String? fcmToken,
  });

  Future<AuthToken> refreshAuthToken({
    required final String refreshToken,
    required final String deviceToken,
    final String? fcmToken,
  });
}
