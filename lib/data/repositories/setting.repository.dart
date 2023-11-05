// 🌎 Project imports:
import 'package:gifthub/data/sources/setting.storage.dart';
import 'package:gifthub/domain/repositories/setting.repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingStorage _settingStoreage;

  SettingRepositoryImpl(this._settingStoreage);

  @override
  bool get isTutorialPending {
    return _settingStoreage.isTutorialPending;
  }

  @override
  set isTutorialPending(bool value) {
    _settingStoreage.isTutorialPending = value;
  }
}
