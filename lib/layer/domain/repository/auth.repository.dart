// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';

mixin AuthRepositoryMixin {
  Future<Tokens> signIn({required String username, required String password});
  Future<Tokens> signUp({
    required String username,
    required String password,
    required String nickname,
  });
  Future<bool> signOut();
}
