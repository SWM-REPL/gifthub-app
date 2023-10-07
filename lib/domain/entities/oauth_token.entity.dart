// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class OAuthToken with EquatableMixin {
  final String accessToken;
  final String refreshToken;

  OAuthToken({
    required this.accessToken,
    required this.refreshToken,
  });

  bool get isStaled => JwtDecoder.isExpired(accessToken);
  bool get isExpired => JwtDecoder.isExpired(refreshToken);
  int get userId => JwtDecoder.decode(accessToken)['userId'];

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
