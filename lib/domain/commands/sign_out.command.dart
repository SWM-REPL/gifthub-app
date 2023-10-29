// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class SignOutCommand extends Command {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  SignOutCommand({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        super('sign_out', analytics);

  Future<void> call() async {
    try {
      final authToken = await _tokenRepository.getAuthToken();
      if (authToken == null) {
        throw UnauthorizedException();
      }
      await _authRepository.signOut(
        accessToken: authToken.accessToken,
        deviceToken: await _tokenRepository.getDeviceToken(),
        fcmToken: await _tokenRepository.getFcmToken(),
      );
      await _tokenRepository.deleteAuthToken();
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
