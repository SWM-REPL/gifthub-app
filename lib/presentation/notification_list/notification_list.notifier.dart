// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/notification_list/notification_list.state.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';

class NotificationListStateNotifier
    extends AutoDisposeAsyncNotifier<NotificationListState> {
  @override
  Future<NotificationListState> build() async {
    final notifications = await ref.watch(notificationsProvider.future);
    final notificationCards = notifications.map(
      (n) async {
        final voucherId = n.voucherId;
        return NotificationCardState(
          notification: await ref.watch(notificationProvider(n.id).future),
          voucher: voucherId != null
              ? await ref.watch(voucherProvider(voucherId).future)
              : null,
        );
      },
    );
    return NotificationListState(
      notifications: await Future.wait(notificationCards),
    );
  }
}

final notificationListStateProvider = AsyncNotifierProvider.autoDispose<
    NotificationListStateNotifier, NotificationListState>(
  () => NotificationListStateNotifier(),
);
