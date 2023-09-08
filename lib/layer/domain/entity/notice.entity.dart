// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Notice with EquatableMixin {
  const Notice({
    required this.id,
    required this.voucherId,
    required this.type,
    required this.message,
    required this.notifiedAt,
  });

  final int id;
  final int voucherId;
  final String type;
  final String message;
  final DateTime notifiedAt;

  @override
  List<Object?> get props => [id];
}
