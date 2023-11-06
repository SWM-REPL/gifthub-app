// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth.entity.dart';
import 'package:gifthub/domain/entities/user.entity.dart';

class AppUser extends User with EquatableMixin {
  final List<OAuth> oauth;
  final bool allowNotifications;
  final bool isAnonymous;

  AppUser({
    required super.id,
    required super.nickname,
    required super.username,
    required this.oauth,
    required this.allowNotifications,
    required this.isAnonymous,
  });

  @override
  List<Object?> get props => [
        super.id,
        super.nickname,
        super.username,
        oauth,
        allowNotifications,
        isAnonymous,
      ];

  AppUser copyWith({
    int? id,
    String? nickname,
    String? username,
    List<OAuth>? oauth,
    bool? allowNotifications,
    bool? isAnonymous,
  }) =>
      AppUser(
        id: id ?? super.id,
        nickname: nickname ?? super.nickname,
        username: username ?? super.username,
        oauth: oauth ?? this.oauth,
        allowNotifications: allowNotifications ?? this.allowNotifications,
        isAnonymous: isAnonymous ?? this.isAnonymous,
      );
}
