// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/sign_in.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/auth.repository.provider.dart';

final signInProvider = Provider(
  (ref) => SignIn(
    repository: ref.read(authRepositoryProvider),
  ),
);
