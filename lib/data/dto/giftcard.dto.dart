// 🌎 Project imports:
import 'package:gifthub/domain/entities/giftcard.entity.dart';

class GiftcardDto extends Giftcard {
  GiftcardDto({
    required super.id,
    required super.password,
  });

  factory GiftcardDto.fromJson(Map<String, dynamic> json) {
    return GiftcardDto(
      id: json['id'],
      password: json['password'],
    );
  }
}
