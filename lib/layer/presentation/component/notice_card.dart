// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/component/voucher_card.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';

class NoticeCard extends ConsumerWidget {
  const NoticeCard(this.notice, {super.key});

  final Notice notice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vpb = ref.watch(vpbProvider(notice.voucherId));
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications,
                color: Colors.amber,
              ),
              Text(
                notice.type,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                notice.notifiedAt.toIso8601String(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(notice.message),
          vpb.when(
            data: (data) => VoucherCard(data),
            loading: () => const InProgress(),
            error: (error, stackTrace) => throw error,
          ),
        ],
      ),
    );
  }
}
