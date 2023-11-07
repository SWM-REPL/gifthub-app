// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class RetrieveVoucherCommand extends Command {
  final VoucherRepository _voucherRepository;
  final int voucherId;

  RetrieveVoucherCommand({
    required this.voucherId,
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('retrieve_voucher', analytics);

  Future<void> call() async {
    try {
      await _voucherRepository.retrieveVoucher(voucherId);
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
