// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmTokenProvider = FutureProvider<String?>((ref) async {
  return await FirebaseMessaging.instance.getToken();
});
