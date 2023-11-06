// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/oauth.dto.dart';
import 'package:gifthub/domain/entities/appuser.entity.dart';

class AppUserDto extends AppUser with EquatableMixin {
  AppUserDto({
    required super.id,
    required super.username,
    required super.nickname,
    required super.oauth,
    required super.allowNotifications,
    required super.isAnonymous,
  });

  factory AppUserDto.fromJson(Map<String, dynamic> json) {
    return AppUserDto(
      id: json['id'],
      username: json['username'],
      nickname: json['nickname'],
      oauth: (json['oauth'] as List).map((e) => OAuthDto.fromJson(e)).toList(),
      allowNotifications: json['allow_notifications'],
      isAnonymous: json['is_anonymous'],
    );
  }

  @override
  List<Object?> get props => [username, nickname, oauth];
}
