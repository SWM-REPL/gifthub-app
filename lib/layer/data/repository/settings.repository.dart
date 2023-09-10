// 🌎 Project imports:
import 'package:gifthub/layer/data/source/local/settings.storage.dart';
import 'package:gifthub/layer/domain/entity/settings.entity.dart';
import 'package:gifthub/layer/domain/repository/settings.repository.dart';

class SettingsRepository with SettingsRepositoryMixin {
  SettingsRepository(this.settingsStorage);

  final SettingsStorageMixin settingsStorage;

  @override
  Future<Settings> loadSettings() async {
    return settingsStorage.loadSettings();
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await settingsStorage.saveSettings(settings);
  }
}
