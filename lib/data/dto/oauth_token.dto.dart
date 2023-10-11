// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';

class AuthTokenDto extends AuthToken with EquatableMixin {
  AuthTokenDto({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthTokenDto.from(final AuthToken token) {
    return AuthTokenDto(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    );
  }

  factory AuthTokenDto.fromJson(final Map<String, dynamic> json) {
    return AuthTokenDto(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
