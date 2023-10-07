// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';

class ProductDto extends Product {
  ProductDto({
    required super.id,
    required super.brandId,
    required super.name,
    required super.description,
    required super.isReusable,
    required super.price,
    required super.imageUrl,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'],
      brandId: json['brand_id'],
      name: json['name'],
      description: json['description'],
      isReusable: json['is_reusable'] == 1,
      price: json['price'],
      imageUrl: json['image_url'],
    );
  }
}
