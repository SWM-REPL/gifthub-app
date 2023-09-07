// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/notification.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/notification.api.provider.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepository(
    api: ref.read(notificationApiProvider),
  ),
);
