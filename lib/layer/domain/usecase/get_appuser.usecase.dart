// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/domain/repository/tokens.repository.dart';

class GetAppUser {
  GetAppUser({
    required this.repository,
  });

  final TokensRepositoryMixin repository;

  Future<User> call() async {
    final tokens = await repository.loadTokens();
    return User(
      nickname: tokens?.nickname ?? '',
    );
  }
}
