import 'package:flutter/material.dart';

import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.view.dart';

class VoucherListPage extends StatelessWidget {
  const VoucherListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: VoucherListView(),
      ),
    );
  }
}
