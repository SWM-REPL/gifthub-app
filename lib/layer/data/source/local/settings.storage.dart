// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/settings.dto.dart';
import 'package:gifthub/layer/domain/entity/settings.entity.dart';

const cachedSettingsKey = 'CACHED_SETTINGS_KEY';

mixin SettingsStorageMixin {
  Future<void> saveSettings(Settings settings);
  Settings loadSettings();
  void resetSettings();
}

class SettingsStorage with SettingsStorageMixin {
  SettingsStorage(
    this._storage,
  );

  final SharedPreferences _storage;

  @override
  Future<void> saveSettings(Settings settings) async {
    final settingsRaw = json.encode(SettingsDto(
      showNotice: settings.showNotice,
    ).toJson());
    await _storage.setString(cachedSettingsKey, settingsRaw);
  }

  @override
  Settings loadSettings() {
    final settingsRaw = _storage.getString(cachedSettingsKey);
    if (settingsRaw == null) {
      return SettingsDto();
    }

    final settingsJson = json.decode(settingsRaw);
    return SettingsDto.fromJson(settingsJson);
  }

  @override
  void resetSettings() {
    _storage.remove(cachedSettingsKey);
  }
}
