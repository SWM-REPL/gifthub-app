// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/settings.entity.dart';

mixin SettingsRepositoryMixin {
  Future<Settings> loadSettings();
  Future<void> saveSettings(Settings settings);
}
