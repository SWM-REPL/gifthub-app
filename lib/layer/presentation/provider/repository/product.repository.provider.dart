// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/product.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/product.api.provider.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(
    api: ref.read(productApiProvider),
  ),
);
