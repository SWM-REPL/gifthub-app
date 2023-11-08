// 🌎 Project imports:
import 'package:gifthub/domain/entities/remote_config.entity.dart';

abstract class SettingRepository {
  bool get isTutorialPending;
  set isTutorialPending(bool value);

  Future<RemoteConfig> getRemoteConfig();

  void clear();
}
