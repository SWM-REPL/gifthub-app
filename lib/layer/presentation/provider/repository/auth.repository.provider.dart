// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/auth.repository.dart';
import 'package:gifthub/layer/presentation/provider/repository/tokens.repository.provider.dart';
import 'package:gifthub/layer/presentation/provider/source/auth.api.provider.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    authApi: ref.read(authApiProvider),
    tokensRepository: ref.read(tokensRepositoryProvider),
  ),
);
