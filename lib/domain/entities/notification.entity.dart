// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Notification with EquatableMixin {
  int id;
  int? voucherId;
  String type;
  String message;
  DateTime notifiedAt;
  DateTime? checkedAt;

  Notification({
    required this.id,
    required this.voucherId,
    required this.type,
    required this.message,
    required this.notifiedAt,
    this.checkedAt,
  });

  @override
  List<Object?> get props => [id];

  Notification copyWith({
    int? id,
    int? voucherId,
    String? type,
    String? message,
    DateTime? notifiedAt,
    DateTime? checkedAt,
  }) {
    return Notification(
      id: id ?? this.id,
      voucherId: voucherId ?? this.voucherId,
      type: type ?? this.type,
      message: message ?? this.message,
      notifiedAt: notifiedAt ?? this.notifiedAt,
      checkedAt: checkedAt ?? this.checkedAt,
    );
  }
}
