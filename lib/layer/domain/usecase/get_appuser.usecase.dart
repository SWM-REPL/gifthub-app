// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/domain/repository/tokens.repository.dart';

class GetAppUser {
  GetAppUser({
    required this.repository,
  });

  final TokensRepositoryMixin repository;

  Future<User> call() async {
    final tokens = await repository.loadTokens();
    if (tokens == null) {
      throw UnauthorizedException();
    }

    return User(
      id: tokens.userId,
      nickname: tokens.nickname,
    );
  }
}
