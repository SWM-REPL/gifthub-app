// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_notifications.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/notification.repository.provider.dart';

final getNotificationProvider = Provider(
  (ref) => GetNotifications(
    repository: ref.read(notificationRepositoryProvider),
  ),
);
