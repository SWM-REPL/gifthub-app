// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';

class UserDto extends User {
  const UserDto({
    required int id,
    required String nickname,
  }) : super(
          id: id,
          nickname: nickname,
        );

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
    };
  }
}
