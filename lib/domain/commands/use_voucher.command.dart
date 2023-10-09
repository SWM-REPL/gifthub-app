// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class UseVoucherCommand extends Command {
  final VoucherRepository _voucherRepository;

  UseVoucherCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('use_voucher', analytics);

  Future<void> call(int id, int amount) async {
    try {
      await _voucherRepository.useVoucher(id, amount: amount);
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
