// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/token.repository.dart';

class SignUp {
  SignUp({required TokenRepositoryMixin repository}) : _repository = repository;

  final TokenRepositoryMixin _repository;

  Future<bool> call({
    required String username,
    required String password,
    required String nickname,
  }) async {
    return await _repository.signUp(
      username: username,
      password: password,
      nickname: nickname,
    );
  }
}
