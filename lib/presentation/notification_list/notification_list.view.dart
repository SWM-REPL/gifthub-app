// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/notification.entity.dart' as entity;
import 'package:gifthub/domain/exceptions/device_offline.exception.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/notification_list/notification_setting.view.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/utility/format_string.dart';
import 'package:gifthub/utility/navigator.dart';

class NotificationListView extends ConsumerWidget {
  static const double padding = 10;

  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('알림'),
      actions: [
        IconButton(
          onPressed: () => navigate(const NotificationSettingView()),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    return notifications.when(
      data: (notifications) => _buildData(context, ref, notifications),
      loading: () => const Loading(),
      error: (error, stackTrace) =>
          _buildError(context, ref, error, stackTrace),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
    List<entity.Notification> notifications,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(padding),
      itemCount: notifications.length,
      itemBuilder: (context, index) =>
          _buildNotificationCard(context, ref, notifications[index].id),
      separatorBuilder: (context, index) => const SizedBox(height: padding),
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref,
    Object error,
    StackTrace? stackTrace,
  ) {
    if (error is DeviceOfflineException) {
      return Center(
        child: Column(children: [
          const Text('Device is offline'),
          ElevatedButton(
            onPressed: () => ref.invalidate(notificationsProvider),
            child: const Text('Retry'),
          )
        ]),
      );
    }
    throw error;
  }

  Widget _buildNotificationCard(
    BuildContext context,
    WidgetRef ref,
    int notificationId,
  ) {
    final notification = ref.watch(notificationProvider(notificationId));
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: notification.when(
          data: (notification) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications,
                          color: Colors.amber,
                        ),
                        Text(
                          notification.type,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          relativeDateFormat(notification.notifiedAt),
                        ),
                        const Text(' 알림'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Text(
                  notification.message,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (notification.voucherId != null)
                VoucherCard(notification.voucherId!),
            ],
          ),
          loading: () => const Loading(),
          error: (error, stackTrace) {
            throw error;
          },
        ),
      ),
    );
  }
}
