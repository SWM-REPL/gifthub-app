// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Tokens with EquatableMixin {
  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  final String accessToken;
  final String refreshToken;

  String get nickname {
    final payload = JwtDecoder.decode(accessToken);
    return payload['sub'];
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
