// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/sources/giftcard.api.dart';
import 'package:gifthub/domain/exceptions/giftcard_expired.exception.dart';
import 'package:gifthub/domain/exceptions/giftcard_not_found.exception.dart';
import 'package:gifthub/domain/repositories/giftcard.repository.dart';

class GiftcardRepositoryImpl implements GiftcardRepository {
  final GiftcardApi _giftcardApi;

  GiftcardRepositoryImpl({
    required GiftcardApi giftcardApi,
  }) : _giftcardApi = giftcardApi;

  @override
  Future<void> acquireGiftcard(String id) async {
    try {
      return await _giftcardApi.acquireGiftcard(id);
    } on DioException catch (e) {
      if (e.response == null) {
        rethrow;
      }

      if (e.response!.statusCode == 400) {
        throw GiftcardExpiredException();
      } else if (e.response!.statusCode == 404) {
        throw GiftcardNotFoundException();
      }
    }
  }
}
