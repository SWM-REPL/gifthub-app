// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/null_fcm_token.exception.dart';
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

  Future<bool> call(String username, String password) async {
    final result = await _authRepository.signIn(
      username: username,
      password: password,
    );
    if (result) {
      FirebaseMessaging.instance.getToken().then((fcmToken) {
        if (fcmToken == null) {
          throw NullFcmTokenException();
        }
        _noticeRepository.updateFcmToken(fcmToken);
      });
    }

    return result;
  }
}
