// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class SignInWithNaverCommand extends Command {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  SignInWithNaverCommand({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        super('sign_in_with_naver', analytics);

  Future<AuthToken> call() async {
    try {
      final authToken = await _authRepository.signInWithNaver();
      await _tokenRepository.saveAuthToken(authToken);
      logSuccess();
      return authToken;
    } catch (error, stackTrace) {
      logFailure(error, stackTrace);
      rethrow;
    }
  }
}
