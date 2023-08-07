// 🌎 Project imports:
import 'package:gifthub/layer/domain/repository/token.repository.dart';

class SignOut {
  SignOut({required TokenRepositoryMixin repository})
      : _repository = repository;

  final TokenRepositoryMixin _repository;

  Future<bool> call() async {
    return await _repository.signOut();
  }
}
