// 🌎 Project imports:
import 'package:gifthub/domain/entities/oauth_token.entity.dart';

abstract class TokenRepository {
  Future<void> saveOAuthToken(OAuthToken token);

  Future<void> deleteOAuthToken();

  Future<OAuthToken?> getOAuthToken();

  Future<void> saveFCMToken(String token);

  Future<void> deleteFCMToken();

  Future<String?> getFCMToken();

  Future<void> deleteAll();
}
