// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.content.dart';

class VoucherDetailView extends ConsumerStatefulWidget {
  const VoucherDetailView(
    this.id, {
    super.key,
  });

  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherDetailViewState();
}

class _VoucherDetailViewState extends ConsumerState<VoucherDetailView> {
  @override
  Widget build(BuildContext context) {
    final vpb = ref.watch(vpbProvider(widget.id));
    return vpb.when(
      data: (data) => VoucherDetailContent(data),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        throw error;
      },
    );
  }
}
