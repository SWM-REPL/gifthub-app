// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Notice with EquatableMixin {
  const Notice({
    required this.id,
    required this.voucherId,
    required this.type,
    required this.message,
    required this.notifiedAt,
    this.checkedAt,
  });

  final int id;
  final int voucherId;
  final String type;
  final String message;
  final DateTime notifiedAt;
  final DateTime? checkedAt;

  Notice copyWith({
    int? id,
    int? voucherId,
    String? type,
    String? message,
    DateTime? notifiedAt,
    DateTime? checkedAt,
  }) {
    return Notice(
      id: id ?? this.id,
      voucherId: voucherId ?? this.voucherId,
      type: type ?? this.type,
      message: message ?? this.message,
      notifiedAt: notifiedAt ?? this.notifiedAt,
      checkedAt: checkedAt ?? this.checkedAt,
    );
  }

  @override
  List<Object?> get props => [id];
}
