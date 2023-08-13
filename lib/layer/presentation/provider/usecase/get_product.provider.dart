// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_product.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/product.repository.provider.dart';

final getProductProvider = Provider(
  (ref) => GetProduct(
    repository: ref.read(productRepositoryProvider),
  ),
);
