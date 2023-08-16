// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Tokens with EquatableMixin {
  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

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

  String get nickname {
    final payload = JwtDecoder.decode(accessToken);
    return payload['sub'];
  }

  int get userId {
    final payload = JwtDecoder.decode(accessToken);
    return payload['user_id'] ?? 2; // TODO: FIXIT
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
