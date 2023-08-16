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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', width: 150),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      body: const VoucherListView(),
    );
  }
}
