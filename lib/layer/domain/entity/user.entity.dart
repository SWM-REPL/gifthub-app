// 📦 Package imports:
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    required this.id,
    required this.nickname,
  });

  final int id;
  final String nickname;

  @override
  List<Object?> get props => [nickname];
}
