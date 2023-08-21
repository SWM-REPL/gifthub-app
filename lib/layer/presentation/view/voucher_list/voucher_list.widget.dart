// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.widget.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.view.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherList extends StatelessWidget {
  void _openVoucherRegisterWidget(BuildContext context) {
    navigate(
      context: context,
      widget: const VoucherEditor(),
      bottomModal: true,
    );
  }

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => _openVoucherRegisterWidget(context),
        tooltip: 'Register Voucher',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
