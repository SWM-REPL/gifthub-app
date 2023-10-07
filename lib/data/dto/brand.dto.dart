// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';

class BrandDto extends Brand {
  BrandDto({
    required super.id,
    required super.name,
    required super.logoUrl,
  });

  factory BrandDto.fromJson(Map<String, dynamic> json) {
    return BrandDto(
      id: json['id'],
      name: json['name'],
      logoUrl: json['imageUrl'],
    );
  }
}
