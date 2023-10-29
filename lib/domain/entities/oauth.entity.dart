// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:equatable/equatable.dart';

class OAuth with EquatableMixin {
  final String id;
  final String? name;
  final String providerCode;
  final String? email;

  OAuth({
    required this.id,
    required this.name,
    required this.providerCode,
    required this.email,
  });

  ImageIcon get icon => providerCode == 'kakao'
      ? const ImageIcon(AssetImage('assets/kakao.png'), size: 22)
      : providerCode == 'naver'
          ? const ImageIcon(
              AssetImage('assets/naver.png'),
              size: 18,
            )
          : providerCode == 'google'
              ? const ImageIcon(AssetImage('assets/google.png'), size: 24)
              : providerCode == 'apple'
                  ? const ImageIcon(AssetImage('assets/apple.png'), size: 24)
                  : throw Exception(
                      'Unknown OAuth providerCode: "$providerCode"');

  String get provider => providerCode == 'kakao'
      ? '카카오톡'
      : providerCode == 'naver'
          ? '네이버'
          : providerCode == 'google'
              ? '구글'
              : providerCode == 'apple'
                  ? '애플'
                  : throw Exception(
                      'Unknown OAuth providerCode: "$providerCode"');

  @override
  List<Object?> get props => [id, name, provider, email];
}
