import 'package:dio/dio.dart';

import 'package:gifthub/apis/url.dart';
import 'package:gifthub/providers/vouchers.provider.dart';

class VouchersApi {
  static Future<List<int>> fetchVouchers(
    final Dio dio,
  ) async {
    final response = await dio.get(ApiUrl.vouchers);
    return response.data as List<int>;
  }

  static Future<Voucher> fetchVoucher(
    final Dio dio,
    final int id,
  ) async {
    final response = await dio.get(ApiUrl.voucher(id));
    return Voucher.fromJson(response.data);
  }
}
