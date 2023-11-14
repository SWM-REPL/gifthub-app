// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CheckVoucherCommand extends Command {
  final int voucherId;
  final VoucherRepository _voucherRepository;

  CheckVoucherCommand(
    this.voucherId, {
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('check_voucher', analytics);

  Future<void> call() async {
    try {
      _voucherRepository.updateVoucher(
        voucherId,
        isChecked: true,
      );
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
