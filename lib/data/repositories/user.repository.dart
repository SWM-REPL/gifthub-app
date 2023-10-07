// 🌎 Project imports:
import 'package:gifthub/data/dto/user.dto.dart';
import 'package:gifthub/data/sources/user.api.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi _userApi;

  UserRepositoryImpl({
    required UserApi userApi,
  }) : _userApi = userApi;

  @override
  Future<UserDto> getUser(int id) async {
    return await _userApi.getUserById(id);
  }

  @override
  Future<void> updateUser(
    int id, {
    String? nickname,
    String? password,
  }) async {
    await _userApi.updateUserById(
      id,
      nickname: nickname,
      password: password,
    );
  }

  @override
  Future<void> deleteUser(int id) async {
    await _userApi.deleteUserById(id);
  }
}
