// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/provider/entity/notices.provider.dart';
import 'package:gifthub/layer/presentation/view/notice_list/notice_list.widget.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.widget.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.view.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherList extends ConsumerWidget {
  void _openVoucherRegisterWidget(BuildContext context) {
    navigate(
      const VoucherEditor(),
      context: context,
      bottomModal: true,
    );
  }

  VoucherList({
    super.key,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = ref.watch(noticesProvider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Image.asset('assets/logo.png', width: 150),
        actions: [
          Center(
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    ref.invalidate(noticesProvider);
                    navigate(
                      const NoticeList(),
                      context: context,
                    );
                  },
                  icon: const Icon(Icons.notifications_outlined),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                notices.when(
                  data: (data) {
                    final unreadCount = data.notices
                        .where((notice) => notice.checkedAt == null)
                        .length;
                    return unreadCount > 0
                        ? Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: AutoSizeText(
                                  '$unreadCount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) => const SizedBox(),
                )
              ],
            ),
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
