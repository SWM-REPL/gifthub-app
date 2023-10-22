// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class FetchPendingVoucherCountCommand extends Command {
  final VoucherRepository _voucherRepository;

  FetchPendingVoucherCountCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('fetch_pending_voucher_count', analytics);

  Future<int> call(int userId) async {
    try {
      final pendingCount = await _voucherRepository.getPendingCount(userId);
      logSuccess({'count': pendingCount});
      return pendingCount;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
