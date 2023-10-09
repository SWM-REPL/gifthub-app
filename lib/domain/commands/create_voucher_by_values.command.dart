// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CreateVoucherByValuesCommand extends Command {
  final VoucherRepository _voucherRepository;

  CreateVoucherByValuesCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
  })  : _voucherRepository = voucherRepository,
        super('create_voucher_by_values', analytics);

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
      logSuccess();
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
