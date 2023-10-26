// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';

class TokenSdk {
  Future<String?> acquireFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
