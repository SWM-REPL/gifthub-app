// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.view.dart';

class VoucherDetailPage extends StatelessWidget {
  const VoucherDetailPage({
    required this.voucher,
    super.key,
  });

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VoucherDetailView(voucher: voucher),
      ),
    );
  }
}
