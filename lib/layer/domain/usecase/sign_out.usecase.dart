// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/auth.repository.dart';

class SignOut {
  SignOut({required AuthRepositoryMixin repository}) : _repository = repository;

  final AuthRepositoryMixin _repository;

  Future<bool> call() async {
    return await _repository.signOut();
  }
}
