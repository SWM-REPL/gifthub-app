// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';

class NotificationDto extends Notification {
  NotificationDto({
    required super.id,
    required super.voucherId,
    required super.type,
    required super.message,
    required super.notifiedAt,
    super.checkedAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: json['id'],
      voucherId: (json.containsKey('voucher_id') && json['voucher_id'] != null)
          ? json['voucher_id']
          : null,
      type: json['type'],
      message: json['message'],
      notifiedAt: DateTime.parse('${json['notified_at']}Z'),
      checkedAt: (json.containsKey('checked_at') && json['checked_at'] != null)
          ? DateTime.parse('${json['checked_at']}Z')
          : null,
    );
  }
}
