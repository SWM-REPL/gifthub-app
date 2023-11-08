// 🌎 Project imports:
import 'package:gifthub/data/dto/remote_config.dto.dart';
import 'package:gifthub/data/sources/setting.api.dart';
import 'package:gifthub/data/sources/setting.storage.dart';
import 'package:gifthub/domain/repositories/setting.repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingApi _settingApi;
  final SettingStorage _settingStoreage;

  SettingRepositoryImpl({
    required SettingApi settingApi,
    required SettingStorage settingStoreage,
  })  : _settingApi = settingApi,
        _settingStoreage = settingStoreage;

  @override
  bool get isTutorialPending {
    return _settingStoreage.isTutorialPending;
  }

  @override
  set isTutorialPending(bool value) {
    _settingStoreage.isTutorialPending = value;
  }

  @override
  Future<RemoteConfigDto> getRemoteConfig() async {
    return await _settingApi.getRemoteConfig();
  }

  @override
  Future<void> clear() async {
    await _settingStoreage.clear();
  }
}
