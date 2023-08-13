// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/auth.api.dart';

final authApiProvider = Provider<AuthApiMixin>((ref) => AuthApi());
