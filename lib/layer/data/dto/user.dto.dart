// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';

class UserDto extends User {
  const UserDto({
    required String nickname,
  }) : super(
          nickname: nickname,
        );

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      nickname: json['nickname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
    };
  }
}
