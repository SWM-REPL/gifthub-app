// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class InvokeOAuthCommand extends Command {
  final UserRepository _userRepository;

  InvokeOAuthCommand({
    required UserRepository userRepository,
    required FirebaseAnalytics analytics,
  })  : _userRepository = userRepository,
        super('invoke_oauth', analytics);

  Future<void> call(String providerCode) async {
    try {
      await _userRepository.invokeOAuth(providerCode);
      logSuccess();
    } catch (error, stackTrace) {
      logFailure(error, stackTrace);
      rethrow;
    }
  }
}
