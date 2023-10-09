// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class DeleteVoucherCommand {
  final VoucherRepository _voucherRepository;
  final FirebaseAnalytics _analytics;

  DeleteVoucherCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        _analytics = analytics;

  Future<void> call(int id) async {
    try {
      await _voucherRepository.deleteVoucher(id);
      _analytics.logEvent(
        name: 'delete_voucher',
        parameters: {
          'success': true,
        },
      );
    } catch (e) {
      _analytics.logEvent(
        name: 'delete_voucher',
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
