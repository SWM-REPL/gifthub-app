// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/local/settings.storage.dart';
import 'package:gifthub/layer/presentation/provider/source/shared_preferences.instance.dart';

final settingsStorageProvider =
    FutureProvider<SettingsStorageMixin>((ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  return SettingsStorage(sharedPreferences);
});
