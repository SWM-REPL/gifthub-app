// 📦 Package imports:
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    required this.id,
    required this.name,
    required this.nickname,
  });

  final String id;
  final String name;
  final String nickname;

  @override
  List<Object?> get props => [id];
}
