// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/component/voucher_card.dart';
import 'package:gifthub/layer/presentation/notifier/brand_filter.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/vpbs.notifier.dart';

class VoucherList extends ConsumerStatefulWidget {
  const VoucherList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoucherListState();
}

class _VoucherListState extends ConsumerState<VoucherList> {
  @override
  Widget build(BuildContext context) {
    final vpbs = ref.watch(vpbsProvider);
    return vpbs.when(
      data: (data) => _VoucherListContent(data),
      loading: () {
        if (vpbs.hasValue) {
          return _VoucherListContent(vpbs.value!);
        } else {
          return const InProgress();
        }
      },
      error: (error, stackTrace) {
        throw error;
      },
    );
  }
}

class _VoucherListContent extends ConsumerWidget {
  const _VoucherListContent(this.vpbs);

  final List<VPB> vpbs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandFilter = ref.watch(brandFilterProvider);
    vpbs.sort((a, b) {
      if (a.voucher.isUsable && b.voucher.isUsable) {
        return a.voucher.expiredDate.compareTo(b.voucher.expiredDate);
      } else if (a.voucher.isUsable) {
        return -1;
      } else {
        return 1;
      }
    });
    return Column(
      children: brandFilter == null
          ? vpbs.map((vpb) => VoucherCard(vpb)).toList()
          : vpbs
              .where(
                (vpb) => vpb.brand.id == brandFilter,
              )
              .map((vpb) => VoucherCard(vpb))
              .toList(),
    );
  }
}
