import 'package:gifthub/layer/domain/repository/token.repository.dart';

class SignIn {
  SignIn({required TokenRepositoryMixin repository}) : _repository = repository;

  final TokenRepositoryMixin _repository;

  Future<bool> call(String username, String password) async {
    return await _repository.signIn(
      username: username,
      password: password,
    );
  }
}
