// 🌎 Project imports:
import 'package:gifthub/domain/entities/user.entity.dart';

abstract class UserRepository {
  Future<User> getUser(int id);

  Future<void> updateUser(
    int id, {
    String? nickname,
    String? password,
  });

  Future<void> deleteUser(int id);
}
