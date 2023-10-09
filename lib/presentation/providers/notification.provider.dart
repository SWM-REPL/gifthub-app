// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';

class NotificationNotifier extends AsyncNotifier<List<Notification>> {
  @override
  Future<List<Notification>> build() {
    return _fetch();
  }

  Future<List<Notification>> _fetch() async {
    final fetchNotifications = ref.watch(fetchNotificationsCommandProvider);
    return await fetchNotifications();
  }
}

final notificationsProvider =
    AsyncNotifierProvider<NotificationNotifier, List<Notification>>(
  () => NotificationNotifier(),
);
