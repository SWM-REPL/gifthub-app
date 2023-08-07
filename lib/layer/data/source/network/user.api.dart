// 🌎 Project imports:
import 'package:gifthub/layer/data/dto/user.dto.dart';
import 'package:gifthub/layer/data/source/network/dio.instance.dart';

mixin UserApiMixin {
  Future<UserDto> loadUser({
    required int id,
  });
  Future<List<UserDto>> loadUsers();
}

class UserApi with DioMixin, UserApiMixin {
  @override
  Future<UserDto> loadUser({
    required int id,
  }) async {
    final String endpoint = '/users/$id';

    final response = await dio.get(
      endpoint,
    );
    return UserDto.fromJson(response.data);
  }

  @override
  Future<List<UserDto>> loadUsers() async {
    const String endpoint = '/users';

    final response = await dio.get(endpoint);
    return (response.data as List)
        .map((elem) => UserDto.fromJson(elem))
        .toList(growable: false);
  }
}
