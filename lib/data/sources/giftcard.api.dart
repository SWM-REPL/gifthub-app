// 📦 Package imports:
import 'package:dio/dio.dart';

class GiftcardApi {
  final Dio dio;

  GiftcardApi(this.dio);

  Future<void> acquireGiftcard(String id) async {
    await dio.post('/giftcards/$id/acquire');
  }
}
