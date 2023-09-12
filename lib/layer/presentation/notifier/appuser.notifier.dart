// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_appuser.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/sign_in.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/sign_out.provider.dart';
import 'package:gifthub/layer/presentation/provider/usecase/sign_up.provider.dart';

class AppUserNotifier extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    return await _fetchUser();
  }

  Future<void> signIn(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final signIn = ref.watch(signInProvider);
      await signIn(username, password);
      return await _fetchUser();
    });
  }

  Future<void> signUp(String username, String password, String nickname) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final signUp = ref.watch(signUpProvider);
      await signUp(
        username: username,
        password: password,
        nickname: nickname,
      );
      return await _fetchUser();
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final signOut = ref.watch(signOutProvider);
      await signOut();
      return await _fetchUser();
    });
  }

  Future<User> _fetchUser() async {
    final getUser = ref.watch(getAppUserProvider);
    return await getUser();
  }
}

final appUserProvider = AsyncNotifierProvider<AppUserNotifier, User>(
  () => AppUserNotifier(),
);
