// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/auth.repository.dart';

class SignIn {
  SignIn({required AuthRepositoryMixin repository}) : _repository = repository;

  final AuthRepositoryMixin _repository;

  Future<bool> call(String username, String password) async {
    return await _repository.signIn(
      username: username,
      password: password,
    );
  }
}
