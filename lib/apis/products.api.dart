import 'package:dio/dio.dart';

import 'package:gifthub/providers/product.provider.dart';
import 'package:gifthub/apis/url.dart';

class ProductsApi {
  static Future<Product> fetchProduct(
    final Dio dio,
    final int id,
  ) async {
    try {
      final response = await dio.get(ApiUrl.product(id));
      final product = Product.fromJson(response.data);
      return product;
    } on DioException {
      rethrow;
    }
  }
}
