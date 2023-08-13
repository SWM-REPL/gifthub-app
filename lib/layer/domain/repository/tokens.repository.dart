// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/tokens.entity.dart';

mixin TokensRepositoryMixin {
  Future<void> saveTokens(Tokens tokens);
  Future<Tokens?> loadTokens();
  Future<void> deleteTokens();
}
