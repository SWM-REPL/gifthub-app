// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';
import 'package:gifthub/layer/domain/repository/user.repository.dart';

class GetAllUsers {
  GetAllUsers({required UserRepositoryMixin repository})
      : _repository = repository;

  final UserRepositoryMixin _repository;

  Future<List<User>> call() async {
    final list = await _repository.getUsers();
    return list;
  }
}
