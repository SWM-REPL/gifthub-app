// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.content.dart';

class VoucherDetailView extends ConsumerStatefulWidget {
  const VoucherDetailView({required this.voucher, super.key});

  final Voucher voucher;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherDetailViewState();
}

class _VoucherDetailViewState extends ConsumerState<VoucherDetailView> {
  @override
  Widget build(BuildContext context) {
    final voucher = widget.voucher;
    return VoucherDetailContent(voucher: voucher);
  }
}
