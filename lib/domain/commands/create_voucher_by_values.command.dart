// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CreateVoucherByValuesCommand {
  static const name = 'create_voucher_by_values';

  final VoucherRepository _voucherRepository;
  final FirebaseAnalytics _analytics;

  CreateVoucherByValuesCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        _analytics = analytics;

  Future<void> call({
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  }) async {
    try {
      await _voucherRepository.createVoucherByValues(
        barcode: barcode,
        expiresAt: expiresAt,
        productName: productName,
        brandName: brandName,
      );
      _analytics.logEvent(
        name: CreateVoucherByValuesCommand.name,
        parameters: {
          'success': true,
        },
      );
    } catch (e) {
      _analytics.logEvent(
        name: CreateVoucherByValuesCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
