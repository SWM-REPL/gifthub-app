// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';
import 'package:gifthub/layer/domain/repository/auth.repository.dart';

class SignUp {
  SignUp({required AuthRepositoryMixin repository}) : _repository = repository;

  final AuthRepositoryMixin _repository;

  Future<Tokens> call({
    required String username,
    required String password,
    required String nickname,
  }) async {
    final tokens = await _repository.signUp(
      username: username,
      password: password,
      nickname: nickname,
    );
    return tokens;
  }
}
