// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class SignInWithPasswordCommand extends Command {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  SignInWithPasswordCommand({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
    required NotificationRepository notificationRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        super('sign_in_with_password', analytics);

  Future<AuthToken> call(
    String username,
    String password,
  ) async {
    try {
      final authToken = await _authRepository.signInWithPassword(
        username: username,
        password: password,
      );
      await _tokenRepository.saveAuthToken(authToken);
      logSuccess();
      return authToken;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      if (error is DioException) {
        // ignore: avoid_dynamic_calls
        throw SignInException(error.response!.data['error']);
      }
      rethrow;
    }
  }
}
