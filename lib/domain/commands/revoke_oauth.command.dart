// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class RevokeOAuthCommand extends Command {
  final UserRepository _userRepository;

  RevokeOAuthCommand({
    required UserRepository userRepository,
    required FirebaseAnalytics analytics,
  })  : _userRepository = userRepository,
        super('revoke_oauth', analytics);

  Future<void> call(String providerCode) async {
    try {
      await _userRepository.revokeOAuth(providerCode);
      logSuccess();
    } catch (error, stackTrace) {
      logFailure(error, stackTrace);
      rethrow;
    }
  }
}
