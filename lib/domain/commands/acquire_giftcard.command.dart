// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/repositories/giftcard.repository.dart';

class AcquireGiftcardComand extends Command {
  final GiftcardRepository _giftcardRepository;

  final String id;

  AcquireGiftcardComand(
    this.id, {
    required GiftcardRepository giftcardRepository,
    required FirebaseAnalytics analytics,
  })  : _giftcardRepository = giftcardRepository,
        super('acquire_giftcard', analytics);

  Future<void> call() async {
    try {
      await _giftcardRepository.acquireGiftcard(id);
      logSuccess({'id': id});
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
