// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.view.dart';

class VoucherDetail extends StatelessWidget {
  const VoucherDetail(
    this.id, {
    super.key,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: VoucherDetailView(id),
    );
  }
}
