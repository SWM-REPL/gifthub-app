// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';

class UserDto extends User {
  const UserDto({
    required int id,
    required String nickname,
    required String username,
  }) : super(
          id: id,
          nickname: nickname,
          username: username,
        );

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
    };
  }
}
