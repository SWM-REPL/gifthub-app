// 🌎 Project imports:
import 'package:gifthub/data/dto/appuser.dto.dart';
import 'package:gifthub/data/dto/user.dto.dart';
import 'package:gifthub/data/sources/auth.sdk.dart';
import 'package:gifthub/data/sources/user.api.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi _userApi;
  final AuthSdk _authSdk;

  UserRepositoryImpl({
    required UserApi userApi,
    required AuthSdk authSdk,
  })  : _userApi = userApi,
        _authSdk = authSdk;

  @override
  Future<AppUserDto> getMe() async {
    return await _userApi.getMe();
  }

  @override
  Future<UserDto> getUser(int id) async {
    return await _userApi.getUserById(id);
  }

  @override
  Future<void> invokeOAuth(String providerCode) async {
    final token = await _authSdk.acquireOAuthToken(providerCode);
    if (token == null) {
      throw Exception('사용자가 로그인을 취소했습니다.');
    }
    await _userApi.invokeOAuth(providerCode, token);
  }

  @override
  Future<void> revokeOAuth(String providerCode) async {
    await _userApi.revokeOAuth(providerCode);
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
