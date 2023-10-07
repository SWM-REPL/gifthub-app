// 🌎 Project imports:
import 'package:gifthub/domain/entities/user.entity.dart';

class UserDto extends User {
  UserDto({
    required super.id,
    required super.nickname,
    required super.username,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      nickname: json['nickname'],
      username: json['username'],
    );
  }
}
