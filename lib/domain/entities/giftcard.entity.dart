// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Giftcard with EquatableMixin {
  String id;
  String password;

  Giftcard({
    required this.id,
    required this.password,
  });

  @override
  List<Object?> get props => [id, password];
}
