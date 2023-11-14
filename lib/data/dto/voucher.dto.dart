// 🌎 Project imports:
import 'package:gifthub/domain/entities/voucher.entity.dart';

class VoucherDto extends Voucher {
  VoucherDto({
    required super.id,
    required super.productId,
    required super.barcode,
    required super.expiresAt,
    required super.price,
    required super.balance,
    required super.isAccessible,
    required super.isShared,
    required super.isChecked,
    super.imageUrl,
  });

  factory VoucherDto.fromJson(Map<String, dynamic> json) {
    return VoucherDto(
      id: json['id'],
      productId: json['product_id'],
      barcode: json['barcode'],
      expiresAt: DateTime.parse(json['expires_at']),
      balance: json['balance'],
      isAccessible: json['is_accessible'],
      isShared: json['is_shared'],
      isChecked: json['is_checked'],
      price: json['price'],
      imageUrl: json.containsKey('image_url') ? json['image_url'] : null,
    );
  }
}
