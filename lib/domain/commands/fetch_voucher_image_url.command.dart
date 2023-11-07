// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class FetchVoucherImageUrlCommand extends Command {
  final VoucherRepository _voucherRepository;
  final int id;

  FetchVoucherImageUrlCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
    required this.id,
  })  : _voucherRepository = voucherRepository,
        super('fetch_voucher_image_url', analytics);

  Future<String> call() async {
    try {
      final url = await _voucherRepository.getImageUrl(id);
      logSuccess({
        'id': id.toString(),
        'url': url,
      });
      return url;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
