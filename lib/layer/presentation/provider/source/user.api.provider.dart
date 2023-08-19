// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/user.api.dart';

final userApiProvider = Provider<UserApiMixin>((ref) => UserApi());
