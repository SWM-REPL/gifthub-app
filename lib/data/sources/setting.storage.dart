// 📦 Package imports:
import 'package:localstorage/localstorage.dart';

class SettingStorage {
  static const _pendingTutorialKey = 'TUTORIAL_KEY';

  final LocalStorage storage;

  SettingStorage(this.storage);

  bool get isTutorialPending {
    final pendingTutorial = storage.getItem(_pendingTutorialKey);
    return pendingTutorial == null ? true : pendingTutorial as bool;
  }

  set isTutorialPending(bool value) {
    storage.setItem(_pendingTutorialKey, value);
  }
}
