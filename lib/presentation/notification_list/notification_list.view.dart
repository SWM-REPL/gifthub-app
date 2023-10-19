// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/device_offline.exception.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/notification_list/notification_list.notifier.dart';
import 'package:gifthub/presentation/notification_list/notification_list.state.dart';
import 'package:gifthub/utility/format_string.dart';

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
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationListStateProvider);
    return state.when(
      data: (state) => _buildData(context, ref, state),
      loading: () => const Loading(),
      error: (error, stackTrace) =>
          _buildError(context, ref, error, stackTrace),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
    NotificationListState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: ListView.separated(
        itemCount: state.notifications.length,
        itemBuilder: (context, index) =>
            _buildNotificationCard(context, state.notifications[index]),
        separatorBuilder: (context, index) => const SizedBox(height: padding),
      ),
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
            onPressed: () => ref.invalidate(notificationListStateProvider),
            child: const Text('Retry'),
          )
        ]),
      );
    }
    throw error;
  }

  Widget _buildNotificationCard(
      BuildContext context, NotificationCardState state) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
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
                        state.notification.type,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        relativeDateFormat(state.notification.notifiedAt),
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
                state.notification.message,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (state.voucher != null) VoucherCard(state.voucher!.id),
          ],
        ),
      ),
    );
  }
}
