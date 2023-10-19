// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class DeregisterCommand extends Command {
  final TokenRepository _tokenRepository;
  final UserRepository _userRepository;

  DeregisterCommand({
    required final TokenRepository tokenRepository,
    required final UserRepository userRepository,
    required final FirebaseAnalytics analytics,
  })  : _tokenRepository = tokenRepository,
        _userRepository = userRepository,
        super('deregister', analytics);

  Future<void> call() async {
    try {
      final oauthToken = await _tokenRepository.getAuthToken();
      if (oauthToken == null) {
        throw UnauthorizedException();
      }
      await _userRepository.deleteUser(oauthToken.userId);
      await _tokenRepository.deleteAll();

      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
