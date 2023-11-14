// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';

class CheckVoucherCommand extends Command {
  final int voucherId;

  CheckVoucherCommand(
    this.voucherId, {
    required FirebaseAnalytics analytics,
  }) : super('check_voucher', analytics);

  Future<void> call() async {
    try {
      return;
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
