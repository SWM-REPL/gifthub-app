// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/notification.api.dart';

final notificationApiProvider =
    Provider<NotificationApiMixin>((ref) => NotificationApi());
