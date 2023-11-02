// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/giftcard.entity.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class ShareVoucherCommand extends Command {
  final VoucherRepository _voucherRepository;
  final int voucherId;
  final String message;

  ShareVoucherCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
    required this.voucherId,
    required this.message,
  })  : _voucherRepository = voucherRepository,
        super('share_voucher', analytics);

  Future<Giftcard> call() async {
    try {
      final giftcard = await _voucherRepository.shareVoucher(
        id: voucherId,
        message: message,
      );
      logSuccess({
        'voucher_id': voucherId.toString(),
        'giftcard_id': giftcard.id.toString(),
      });
      return giftcard;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
