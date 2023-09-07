// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notification.entity.dart';

class NotificationDto extends Notification {
  NotificationDto({
    required super.id,
    required super.voucherId,
    required super.type,
    required super.message,
    required super.notifiedAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: json['id'] as int,
      voucherId: json['voucher_id'] as int,
      type: json['type'] as String,
      message: json['message'] as String,
      notifiedAt: DateTime.parse(json['notified_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'voucher_id': voucherId,
      'type': type,
      'message': message,
      'notified_at': notifiedAt.toIso8601String(),
    };
  }
}
