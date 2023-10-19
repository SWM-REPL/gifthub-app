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
}
