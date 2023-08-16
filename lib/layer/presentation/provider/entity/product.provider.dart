// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/presentation/provider/repository/product.repository.provider.dart';

final productProvider = FutureProvider.family<Product, int>((ref, id) async {
  final productRepository = ref.read(productRepositoryProvider);
  return await productRepository.getProduct(id);
});
