// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthToken with EquatableMixin {
  final String accessToken;
  final String refreshToken;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  bool get isStaled => JwtDecoder.isExpired(accessToken);
  bool get isExpired => JwtDecoder.isExpired(refreshToken);
  int get userId => JwtDecoder.decode(accessToken)['userId'];

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
