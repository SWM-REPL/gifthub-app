// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_product.provider.dart';

class ProductNotifier extends FamilyAsyncNotifier<Product, int> {
  @override
  Future<Product> build(final int arg) async {
    final getProduct = ref.watch(getProductProvider);
    return await getProduct(arg);
  }
}

final productProvider =
    AsyncNotifierProvider.family<ProductNotifier, Product, int>(
  () => ProductNotifier(),
);
