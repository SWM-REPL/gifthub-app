// 📦 Package imports:
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    required this.id,
    required this.username,
    required this.nickname,
  });

  final int id;
  final String username;
  final String nickname;

  @override
  List<Object?> get props => [id];
}
