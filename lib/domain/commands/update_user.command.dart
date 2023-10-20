// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class UpdateUserCommand extends Command {
  final UserRepository _userRepository;

  UpdateUserCommand({
    required UserRepository userRepository,
    required FirebaseAnalytics analytics,
  })  : _userRepository = userRepository,
        super('update_user_info', analytics);

  Future<void> call(
    int id, {
    String? nickname,
    String? password,
  }) async {
    try {
      await _userRepository.updateUser(
        id,
        nickname: nickname,
        password: password,
      );
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
