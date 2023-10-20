// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';

abstract class TokenRepository {
  Future<void> saveAuthToken(AuthToken token);

  Future<void> deleteAuthToken();

  Future<AuthToken?> getAuthToken();
}
