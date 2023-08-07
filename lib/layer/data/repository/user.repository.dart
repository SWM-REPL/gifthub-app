import 'package:gifthub/layer/data/dto/user.dto.dart';
import 'package:gifthub/layer/data/source/network/user.api.dart';
import 'package:gifthub/layer/domain/repository/user.repository.dart';

class UserRepository with UserRepositoryMixin {
  UserRepository({
    required UserApiMixin api,
  }) : _api = api;

  final UserApiMixin _api;

  @override
  Future<UserDto> getUser({required int id}) async {
    final fetchedUser = await _api.loadUser(id: id);
    return fetchedUser;
  }

  @override
  Future<List<UserDto>> getUsers() async {
    final fetchedUsers = await _api.loadUsers();
    return fetchedUsers;
  }
}
