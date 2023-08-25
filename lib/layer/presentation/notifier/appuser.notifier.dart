// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_appuser.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/sign_out.provider.dart';

class AppUserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    return await getAppUser();
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final signOut = ref.watch(signOutProvider);
      await signOut();
      return await getAppUser();
    });
  }

  Future<User> getAppUser() async {
    final getUser = ref.watch(getAppUserProvider);
    return await getUser();
  }
}

final appUserProvider = AsyncNotifierProvider<AppUserNotifier, User>(
  () => AppUserNotifier(),
);
