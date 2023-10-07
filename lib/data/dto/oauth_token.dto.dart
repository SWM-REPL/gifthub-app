// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth_token.entity.dart';

class OAuthTokenDto extends OAuthToken with EquatableMixin {
  OAuthTokenDto({
    required super.accessToken,
    required super.refreshToken,
  });

  factory OAuthTokenDto.from(final OAuthToken token) {
    return OAuthTokenDto(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    );
  }

  factory OAuthTokenDto.fromJson(final Map<String, dynamic> json) {
    return OAuthTokenDto(
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
