// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_appuser.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/tokens.repository.provider.dart';

final getAppUserProvider = Provider(
  (ref) => GetAppUser(
    repository: ref.read(tokensRepositoryProvider),
  ),
);
