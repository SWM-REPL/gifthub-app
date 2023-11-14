// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class UpdateVoucherCommand extends Command {
  final int id;
  final VoucherRepository _voucherRepository;

  UpdateVoucherCommand(
    this.id, {
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('update_voucher', analytics);

  Future<void> call({
    required String barcode,
    int? balance,
    required DateTime expiresAt,
    required String productName,
    required String brandName,
  }) async {
    try {
      await _voucherRepository.updateVoucher(
        id,
        barcode: barcode,
        balance: balance,
        expiresAt: expiresAt,
        productName: productName,
        brandName: brandName,
      );
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
