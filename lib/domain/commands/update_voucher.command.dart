// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class UpdateVoucherCommand {
  static const name = 'update_voucher';

  final VoucherRepository _voucherRepository;
  final FirebaseAnalytics _analytics;

  UpdateVoucherCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        _analytics = analytics;

  Future<void> call({
    required int id,
    required String barcode,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  }) async {
    try {
      await _voucherRepository.updateVoucher(
        id,
        barcode: barcode,
        expiresAt: expiresAt,
        productName: productName,
        brandName: brandName,
      );
      _analytics.logEvent(
        name: UpdateVoucherCommand.name,
        parameters: {
          'success': true,
        },
      );
    } catch (e) {
      _analytics.logEvent(
        name: UpdateVoucherCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
