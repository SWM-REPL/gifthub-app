// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/settings.entity.dart';
import 'package:gifthub/layer/presentation/provider/repository/settings.repository.provider.dart';

class SettingsNotifier extends AsyncNotifier<Settings> {
  @override
  Future<Settings> build() async {
    final settingsRepository =
        await ref.read(settingsRepositoryProvider.future);
    return await settingsRepository.loadSettings();
  }

  Future<void> toggleShowNotice() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final settingsRepository =
          await ref.read(settingsRepositoryProvider.future);
      final settings = await settingsRepository.loadSettings();
      final newSettings = settings.copyWith(showNotice: !settings.showNotice);
      await settingsRepository.saveSettings(newSettings);
      return newSettings;
    });
  }
}

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, Settings>(
  () => SettingsNotifier(),
);
