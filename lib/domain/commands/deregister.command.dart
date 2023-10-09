// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class DeregisterCommand extends Command {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  DeregisterCommand({
    required final AuthRepository authRepository,
    required final UserRepository userRepository,
    required final FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super('deregister', analytics);

  Future<void> call() async {
    try {
      final oauthToken = await _authRepository.loadFromStorage();
      if (oauthToken == null) {
        throw UnauthorizedException();
      }
      await _userRepository.deleteUser(oauthToken.userId);
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
