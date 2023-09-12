// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/null_fcm_token.exception.dart';
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';
import 'package:gifthub/layer/domain/repository/auth.repository.dart';
import 'package:gifthub/layer/domain/repository/notice.repository.dart';

class SignIn {
  SignIn(
      {required AuthRepositoryMixin authRepository,
      required NoticeRepositoryMixin noticeRepository})
      : _authRepository = authRepository,
        _noticeRepository = noticeRepository;

  final AuthRepositoryMixin _authRepository;
  final NoticeRepositoryMixin _noticeRepository;

  Future<Tokens> call(String username, String password) async {
    final tokens = await _authRepository.signIn(
      username: username,
      password: password,
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) {
      throw NullFcmTokenException();
    }
    _noticeRepository.updateFcmToken(fcmToken);
    return tokens;
  }
}
