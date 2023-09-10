// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/settings.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/settings.storage.provider.dart';

final settingsRepositoryProvider =
    FutureProvider<SettingsRepository>((ref) async {
  final settingsStorage = await ref.watch(settingsStorageProvider.future);
  return SettingsRepository(settingsStorage);
});
