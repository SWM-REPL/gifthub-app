// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';

class TokensDto extends Tokens {
  const TokensDto({
    required super.accessToken,
    required super.refreshToken,
  });

  factory TokensDto.fromJson(Map<String, dynamic> json) {
    return TokensDto(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
