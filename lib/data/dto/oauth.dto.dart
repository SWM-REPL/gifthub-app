// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth.entity.dart';

class OAuthDto extends OAuth {
  OAuthDto({
    required super.id,
    required super.name,
    required super.providerCode,
    required super.email,
  });

  factory OAuthDto.fromJson(Map<String, dynamic> json) {
    return OAuthDto(
      id: json['id'],
      name: json['nickname'],
      providerCode: json['provider'].toString().toLowerCase(),
      email: json['email'],
    );
  }
}
