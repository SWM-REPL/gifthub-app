// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/remote_config.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final remoteConfigProvider = FutureProvider<RemoteConfig>((ref) async {
  final settingRepository = await ref.watch(settingRepositoryProvider.future);
  final remoteConfig = await settingRepository.getRemoteConfig();
  return remoteConfig;
});
