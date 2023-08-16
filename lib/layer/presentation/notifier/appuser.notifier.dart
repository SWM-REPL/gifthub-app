// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_appuser.provider.dart';

final appUserProvider = FutureProvider<User>((ref) async {
  final getUser = ref.watch(getAppUserProvider);
  return await getUser();
});
