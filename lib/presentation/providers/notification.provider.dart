// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';

class NotificationsNotifier extends Notifier<List<Notification>> {
  @override
  List<Notification> build() {
    return [];
  }

  void addNotification(Notification notification) {
    state = [...state, notification];
  }

  void removeNotification(Notification notification) {
    state = state.where((element) => element.id != notification.id).toList();
  }

  void markAsRead(Notification notification) {
    state = state.map((n) {
      if (n.id == notification.id) {
        return n.copyWith(checkedAt: DateTime.now());
      } else {
        return n;
      }
    }).toList();
  }
}

final notificationsProvider =
    NotifierProvider<NotificationsNotifier, List<Notification>>(
  () => NotificationsNotifier(),
);
