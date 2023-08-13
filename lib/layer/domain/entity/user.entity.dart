// 📦 Package imports:
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    this.id = 42,
    required this.nickname,
  });

  final int id;
  final String nickname;

  @override
  List<Object?> get props => [nickname];
}
