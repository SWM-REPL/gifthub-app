// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/tokens.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/auth.api.provider.dart';
import 'package:gifthub/main.dart';

final tokensRepositoryProvider = Provider<TokensRepository>(
  (ref) => TokensRepository(
    tokensCache: tokensCache,
    tokensStorage: tokensStorage,
    authApi: ref.read(authApiProvider),
  ),
);
