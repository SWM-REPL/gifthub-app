// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/user.entity.dart';

mixin UserRepositoryMixin {
  Future<User> getUser({required int id});
  Future<List<User>> getUsers();
}
