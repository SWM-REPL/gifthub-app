// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

final productProvider = FutureProvider.family<Product, int>((ref, id) async {
  final productRepository = ref.watch(productRepositoryProvider);
  return await productRepository.getProductById(id);
});
