// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';

final notificationsProvider = FutureProvider<List<Notification>>((ref) async {
  final fetchNotifications = ref.watch(fetchNotificationsCommandProvider);
  return await fetchNotifications();
});

final notificationProvider =
    FutureProvider.family.autoDispose<Notification, int>((ref, id) async {
  final fetchNotification = ref.watch(fetchNotificationCommandProvider(id));
  return await fetchNotification();
});
