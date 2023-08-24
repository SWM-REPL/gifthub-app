// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';

class BrandDto extends Brand {
  BrandDto({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory BrandDto.fromJson(Map<String, dynamic> json) {
    return BrandDto(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
