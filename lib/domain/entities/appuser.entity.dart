// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/entities/user.entity.dart';

class AppUser extends User with EquatableMixin {
  AuthToken tokens;

  AppUser({
    required super.id,
    required super.nickname,
    required super.username,
    required this.tokens,
  });

  factory AppUser.from(
    final User user,
    final AuthToken tokens,
  ) {
    return AppUser(
      id: user.id,
      nickname: user.nickname,
      username: user.username,
      tokens: tokens,
    );
  }

  bool get isStaled => tokens.isStaled;
  bool get isExpired => tokens.isExpired;

  @override
  List<Object?> get props => [
        super.id,
        super.nickname,
        super.username,
        tokens,
      ];
}
