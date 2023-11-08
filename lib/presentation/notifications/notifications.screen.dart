// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/presentation/common/notification_card.widget.dart';
import 'package:gifthub/presentation/notifications/notifications_setting.screen.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/utility/navigator.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  static const double padding = GiftHubConstants.padding;

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
          onPressed: () => navigate(const NotificationsSettingScreen()),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    notifications.sort((a, b) => b.notifiedAt.compareTo(a.notifiedAt));
    return ListView.separated(
      padding: const EdgeInsets.all(padding),
      itemCount: notifications.length,
      itemBuilder: (context, index) =>
          NotificationCard(notifications[index].id),
      separatorBuilder: (context, index) => const SizedBox(height: padding),
    );
  }
}
