// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.view.dart';

class VoucherList extends StatelessWidget {
  const VoucherList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: VoucherListView(),
      ),
    );
  }
}
