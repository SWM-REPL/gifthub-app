// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/appuser.dto.dart';
import 'package:gifthub/data/dto/user.dto.dart';

class UserApi {
  final Dio dio;

  UserApi(this.dio);

  Future<AppUserDto> getMe() async {
    final response = await dio.get('/users/me');
    return AppUserDto.fromJson(response.data);
  }

  Future<UserDto> getUserById(int id) async {
    final response = await dio.get('/users/$id');
    return UserDto.fromJson(response.data);
  }

  Future<void> updateUserById(
    int id, {
    String? nickname,
    String? password,
  }) async {
    await dio.patch('/users/$id', data: {
      'nickname': nickname,
      'password': password,
    });
  }

  Future<void> deleteUserById(int id) async {
    await dio.delete('/users/$id');
  }
}
