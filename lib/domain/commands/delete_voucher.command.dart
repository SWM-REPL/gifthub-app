// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class DeleteVoucherCommand extends Command {
  final VoucherRepository _voucherRepository;

  DeleteVoucherCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('delete_voucher', analytics);

  Future<void> call(int id) async {
    try {
      await _voucherRepository.deleteVoucher(id);
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
