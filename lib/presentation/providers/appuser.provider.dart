// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/appuser.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final appUserProvider = FutureProvider<AppUser>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return await userRepository.getMe();
});
