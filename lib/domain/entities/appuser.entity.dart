// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth.entity.dart';
import 'package:gifthub/domain/entities/user.entity.dart';

class AppUser extends User with EquatableMixin {
  final List<OAuth> oauth;
  final bool allowNotifications;

  AppUser({
    required super.id,
    required super.nickname,
    required super.username,
    required this.oauth,
    required this.allowNotifications,
  });

  @override
  List<Object?> get props => [
        super.id,
        super.nickname,
        super.username,
        oauth,
        allowNotifications,
      ];
}
