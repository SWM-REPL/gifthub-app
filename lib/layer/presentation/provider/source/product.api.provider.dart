// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/product.api.dart';

final productApiProvider = Provider<ProductApiMixin>((ref) => ProductApi());
