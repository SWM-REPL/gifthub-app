// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

class VoucherDto extends Voucher {
  VoucherDto({
    required super.id,
    required super.productId,
    required super.barcode,
    required super.expiredDate,
    required super.balance,
  });

  factory VoucherDto.fromJson(Map<String, dynamic> json) {
    return VoucherDto(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      barcode: json['barcode'] as String,
      expiredDate: DateTime.parse(json['expires_at'] as String),
      balance: json['balance'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'barcode': barcode,
      'expired_at': expiredDate.toIso8601String(),
      'balance': balance,
    };
  }
}
