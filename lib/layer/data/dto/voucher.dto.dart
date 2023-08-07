// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

class VoucherDto extends Voucher {
  VoucherDto({
    required int id,
    required int productId,
    required String barcode,
    required DateTime expiredDate,
  }) : super(
          id: id,
          productId: productId,
          barcode: barcode,
          expiredDate: expiredDate,
        );

  factory VoucherDto.fromJson(Map<String, dynamic> json) {
    return VoucherDto(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      barcode: json['barcode'] as String,
      expiredDate: DateTime.parse(json['expires_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'barcode': barcode,
      'expired_at': expiredDate.toIso8601String(),
    };
  }
}
