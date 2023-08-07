import 'package:gifthub/layer/domain/entity/user.entity.dart';

class UserDto extends User {
  const UserDto({
    required String id,
    required String name,
    required String nickname,
  }) : super(
          id: id,
          name: name,
          nickname: nickname,
        );

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
