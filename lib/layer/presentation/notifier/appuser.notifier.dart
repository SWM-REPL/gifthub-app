// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/domain/usecase/get_appuser.usecase.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_appuser.provider.dart';

class AppUserNotifier extends AsyncNotifier<User> {
  late GetAppUser _getUser;

  @override
  Future<User> build() async {
    _getUser = ref.watch(getAppUserProvider);
    return await _getUser();
  }

  void reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getUser();
    });
  }
}

final appUserProvider = AsyncNotifierProvider<AppUserNotifier, User>(
  () => AppUserNotifier(),
);
