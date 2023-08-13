// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';

class ProductDto extends Product {
  const ProductDto({
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
      id: json['id'] as int,
      brandId: json['brand_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      isReusable: json['is_reusable'] as int == 1,
      price: json['price'] as int,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand_id': brandId,
      'name': name,
      'description': description,
      'is_reusable': isReusable,
      'price': price,
      'image_url': imageUrl,
    };
  }
}
