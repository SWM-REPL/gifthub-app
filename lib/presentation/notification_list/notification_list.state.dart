// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';

class NotificationListState with EquatableMixin {
  final List<NotificationCardState> notifications;

  const NotificationListState({
    required this.notifications,
  });

  @override
  List<Object?> get props => [
        notifications,
      ];
}

class NotificationCardState with EquatableMixin {
  final Notification notification;
  final Voucher? voucher;

  const NotificationCardState({
    required this.notification,
    this.voucher,
  });

  @override
  List<Object?> get props => [
        notification,
        voucher,
      ];
}
