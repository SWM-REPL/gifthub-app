// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';

final notificationsProvider = StateProvider<List<Notification>>((ref) {
  return [];
});

final notificationProvider =
    FutureProvider.family.autoDispose<Notification, int>((ref, id) async {
  final fetchNotification = ref.watch(fetchNotificationCommandProvider(id));
  return await fetchNotification();
});
