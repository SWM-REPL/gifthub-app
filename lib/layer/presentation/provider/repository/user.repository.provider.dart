// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/user.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/user.api.provider.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(
    api: ref.read(userApiProvider),
  ),
);
