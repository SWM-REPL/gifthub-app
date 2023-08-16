// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/brand.api.dart';

final brandApiProvider = Provider<BrandApiMixin>((ref) => BrandApi());
