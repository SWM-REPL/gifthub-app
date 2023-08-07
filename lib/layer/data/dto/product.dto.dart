// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';

class ProductDto extends Product {
  const ProductDto({
    required int id,
    required int brandId,
    required String name,
    required String description,
    required bool isReusable,
    required int price,
    required String imageUrl,
  }) : super(
          id: id,
          brandId: brandId,
          name: name,
          description: description,
          isReusable: isReusable,
          price: price,
          imageUrl: imageUrl,
        );

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
