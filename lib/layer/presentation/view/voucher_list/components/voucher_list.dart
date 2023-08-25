// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/brand_filter.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher_ids.provider.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/components/voucher_card.dart';

class VoucherList extends ConsumerStatefulWidget {
  const VoucherList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoucherListState();
}

class _VoucherListState extends ConsumerState<VoucherList> {
  @override
  Widget build(BuildContext context) {
    final ids = ref.watch(voucherIdsProvider);
    return ids.when(
      data: (data) => _VoucherListContent(data),
      loading: () {
        if (ids.hasValue) {
          return _VoucherListContent(ids.value!);
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
  const _VoucherListContent(this.ids);

  final List<int> ids;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandFilter = ref.watch(brandFilterProvider);
    final idsUsable = ids.where(
      (id) => ref.watch(vpbProvider(id)).when(
            data: (vpb) => vpb.voucher.isUsable,
            loading: () => false,
            error: (error, stackTrace) {
              throw error;
            },
          ),
    );
    return Column(
      children: brandFilter == null
          ? idsUsable.map((id) => VoucherCard(id: id)).toList()
          : idsUsable
              .where(
                (id) => ref.watch(vpbProvider(id)).when(
                      data: (vpb) => vpb.brand.id == brandFilter,
                      loading: () => false,
                      error: (error, stackTrace) {
                        throw error;
                      },
                    ),
              )
              .map((id) => VoucherCard(id: id))
              .toList(),
    );
  }
}
