// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/device_offline.exception.dart';
import 'package:gifthub/presentation/common/event_banner.widget.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/placeholder_icon.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/common/voucher_pending_card.widget.dart';
import 'package:gifthub/presentation/editor/editor.screen.dart';
import 'package:gifthub/presentation/home/home.state.dart';
import 'package:gifthub/presentation/home/home_brands.widget.dart';
import 'package:gifthub/presentation/home/home_header.widget.dart';
import 'package:gifthub/presentation/notifications/notifications.screen.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/tutorial/tutorial.screen.dart';
import 'package:gifthub/utility/navigator.dart';

class HomeScreen extends ConsumerWidget {
  static const double padding = 10;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(EditorScreen()),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset('assets/icon.png', height: 72),
          Text(
            'GiftHub',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => navigate(const NotificationsScreen()),
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);
    return homeState.when(
      data: (state) => state.isEmpty
          ? _buildEmpty(context, ref)
          : _buildData(context, ref, state),
      loading: () => const Loading(),
      error: (error, stackTrace) =>
          _buildError(context, ref, error, stackTrace),
    );
  }

  Widget _buildEmpty(BuildContext context, WidgetRef ref) {
    Future.microtask(() async {
      final settingStorage = await ref.watch(settingStorageProvider.future);
      if (settingStorage.isTutorialPending) {
        showModal(const TutorialScreen());
      }
    });
    return const Center(
      child: Column(
        children: [
          HomeHeader(),
          PlaceholderIcon('사용할 수 있는 기프티콘이 없습니다.'),
        ],
      ),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
    HomeState state,
  ) {
    final listItems = <Widget>[
      const HomeHeader(),
      const EventBanner(),
      if (state.brands.isNotEmpty) ...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Text(
            '보유 브랜드 목록',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        const HomeBrands(),
      ],
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Text(
          '보유 기프티콘 목록',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      ),
      ...List.generate(
        state.pendingCount,
        (index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: VoucherPendingCard(),
        ),
      ),
      ...state.filteredVouchers.map(
        (v) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: VoucherCard(v.id),
        ),
      ),
    ];
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(voucherIdsProvider);
      },
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemCount: listItems.length,
        itemBuilder: (context, index) => listItems[index],
        separatorBuilder: (context, index) {
          return const SizedBox(height: padding);
        },
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref,
    Object error,
    StackTrace stackTrace,
  ) {
    if (error is DeviceOfflineException) {
      return Center(
        child: Column(
          children: [
            const Text('Device is offline'),
            ElevatedButton(
              onPressed: () => ref.invalidate(voucherIdsProvider),
              child: const Text('Retry'),
            )
          ],
        ),
      );
    }
    throw error;
  }
}
