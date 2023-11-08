// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';

class NotificationsNotifier extends Notifier<List<Notification>> {
  @override
  List<Notification> build() {
    Future.microtask(() => _fetchAllWithoutRead());
    return [];
  }

  void addNotification(Notification notification) {
    state = [...state, notification];
  }

  void removeNotification(Notification notification) {
    state = state.where((element) => element.id != notification.id).toList();
  }

  void markAllAsRead() {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    state = state.map((n) {
      notificationRepository.getNotification(n.id);
      return n.copyWith(checkedAt: DateTime.now());
    }).toList();
  }

  void _fetchAllWithoutRead() async {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    state = await notificationRepository.getNotifications();
  }
}

final notificationsProvider =
    NotifierProvider<NotificationsNotifier, List<Notification>>(
  () => NotificationsNotifier(),
);
