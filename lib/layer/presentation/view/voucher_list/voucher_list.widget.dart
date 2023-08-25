// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
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

  VoucherList({
    super.key,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Image.asset('assets/logo.png', width: 150),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
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
      endDrawer: const Drawer(
        child: _MenuContent(),
      ),
    );
  }
}

class _MenuContent extends ConsumerWidget {
  const _MenuContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: MediaQuery.of(context).viewPadding.add(
            const EdgeInsets.all(20),
          ),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              final appUser = ref.read(appUserProvider.notifier);
              appUser.signOut();
            },
            child: Text(
              '로그아웃',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
