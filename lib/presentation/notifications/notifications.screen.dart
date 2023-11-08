// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/domain/entities/notification.entity.dart' as entity;
import 'package:gifthub/domain/exceptions/device_offline.exception.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/notification_card.widget.dart';
import 'package:gifthub/presentation/notifications/notifications_setting.screen.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/utility/navigator.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  static const double padding = GiftHubConstants.padding;

  bool isDeleteMode = false;

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => navigate(const NotificationsSettingScreen()),
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
    notifications.sort((a, b) => b.notifiedAt.compareTo(a.notifiedAt));
    return ListView.separated(
      padding: const EdgeInsets.all(padding),
      itemCount: notifications.length,
      itemBuilder: (context, index) => InkWell(
        onLongPress: () => setState(() => isDeleteMode = true),
        onTap: () => setState(() => isDeleteMode = false),
        child: NotificationCard(notifications[index].id),
      ),
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
}
