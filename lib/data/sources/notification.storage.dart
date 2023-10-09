// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationStorage {
  static const _deviceTokenKey = 'CACHED_DEVICETOKEN_KEY';

  final FlutterSecureStorage _secureStorage;

  NotificationStorage(this._secureStorage);

  Future<void> saveDeviceToken(String deviceToken) async {
    await _secureStorage.write(key: _deviceTokenKey, value: deviceToken);
  }

  Future<String?> loadDeviceToken() async {
    return await _secureStorage.read(key: _deviceTokenKey);
  }

  Future<void> deleteDeviceToken() async {
    await _secureStorage.delete(key: _deviceTokenKey);
  }
}
