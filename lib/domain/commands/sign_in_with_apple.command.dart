// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';

class SignInWithAppleCommand extends Command {
  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  SignInWithAppleCommand({
    required AuthRepository authRepository,
    required TokenRepository tokenRepository,
    required FirebaseAnalytics analytics,
  })  : _authRepository = authRepository,
        _tokenRepository = tokenRepository,
        super('sign_in_with_apple', analytics);

  Future<AuthToken> call() async {
    try {
      final authToken = await _authRepository.signInWithApple(
        deviceToken: await _tokenRepository.getDeviceToken(),
        fcmToken: await _tokenRepository.getFcmToken(),
      );
      await _tokenRepository.saveAuthToken(authToken);
      logSuccess();
      return authToken;
    } catch (error, stackTrace) {
      logFailure(error, stackTrace);
      if (error is DioException) {
        // ignore: avoid_dynamic_calls
        throw SignInException(error.response!.data['error']);
      }
      rethrow;
    }
  }
}
