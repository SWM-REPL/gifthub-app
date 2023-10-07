// 📦 Package imports:
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  int id;
  String nickname;
  String username;

  User({
    required this.id,
    required this.nickname,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      username: json['username'],
    );
  }

  @override
  List<Object?> get props => [id, nickname, username];
}
