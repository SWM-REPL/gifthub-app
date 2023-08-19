// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/domain/repository/tokens.repository.dart';
import 'package:gifthub/layer/domain/repository/user.repository.dart';

class GetAppUser {
  GetAppUser({
    required this.tokensRepository,
    required this.userRepository,
  });

  final TokensRepositoryMixin tokensRepository;
  final UserRepositoryMixin userRepository;

  Future<User> call() async {
    final tokens = await tokensRepository.loadTokens();
    if (tokens == null) {
      throw UnauthorizedException();
    }

    return await userRepository.getUser(id: tokens.userId);
  }
}
