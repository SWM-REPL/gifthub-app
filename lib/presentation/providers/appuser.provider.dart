// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/appuser.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final appUserProvider = FutureProvider<AppUser?>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final tokenRepository = ref.watch(tokenRepositoryProvider);

  final tokenFromRef = ref.watch(authTokenProvider);
  final tokenFromStorage = await tokenRepository.getAuthToken();

  if (tokenFromRef != tokenFromStorage) {
    ref.watch(authTokenProvider.notifier).state = tokenFromStorage;
  }

  final token = tokenFromRef ?? tokenFromStorage;
  if (token == null) {
    return null;
  }

  final me = await userRepository.getUser(token.userId);
  return AppUser.from(me, token);
});
