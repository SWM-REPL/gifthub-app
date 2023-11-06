// 📦 Package imports:

// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class SettingStorage {
  static const _pendingTutorialKey = 'TUTORIAL_KEY';

  final SharedPreferences prefs;

  SettingStorage(this.prefs);

  bool get isTutorialPending {
    final pendingTutorial = prefs.getBool(_pendingTutorialKey);
    return pendingTutorial ?? true;
  }

  set isTutorialPending(bool value) {
    prefs.setBool(_pendingTutorialKey, value);
  }

  Future<void> clear() async {
    await Future.wait([
      prefs.remove(_pendingTutorialKey),
    ]);
  }
}
