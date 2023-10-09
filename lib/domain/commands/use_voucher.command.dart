// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class UseVoucherCommand {
  static const name = 'use_voucher';

  final VoucherRepository _voucherRepository;
  final FirebaseAnalytics _analytics;

  UseVoucherCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        _analytics = analytics;

  Future<void> call(int id, int amount) async {
    try {
      await _voucherRepository.useVoucher(id, amount: amount);
      _analytics.logEvent(
        name: UseVoucherCommand.name,
        parameters: {
          'success': true,
        },
      );
    } catch (e) {
      _analytics.logEvent(
        name: UseVoucherCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
