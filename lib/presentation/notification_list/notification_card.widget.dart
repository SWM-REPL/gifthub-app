// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/theme/constant.theme.dart';
import 'package:gifthub/utility/format_string.dart';

class NotificationCard extends ConsumerWidget {
  static const padding = GiftHubConstants.padding;

  final int id;

  const NotificationCard(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notification = ref.watch(notificationProvider(id));
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: notification.when(
          data: (notification) => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: padding / 4),
                          Text(
                            notification.type,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${relativeDateFormat(notification.notifiedAt)} 알림',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: padding),
                  Text(
                    notification.message,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (notification.voucherId != null)
                    VoucherCard(notification.voucherId!),
                ],
              ),
              Positioned(
                top: -15,
                right: -21,
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: '',
                      onTap: () async {
                        await ref.watch(deleteNotificationCommandProvider)(
                          notification.id,
                        );
                        ref.invalidate(notificationsProvider);
                      },
                      child: const Text('삭제하기'),
                    ),
                  ],
                ),
              )
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
