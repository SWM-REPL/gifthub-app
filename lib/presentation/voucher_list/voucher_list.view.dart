// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_break_text/word_break_text.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/exceptions/device_offline.exception.dart';
import 'package:gifthub/presentation/common/icon_placeholder.widget.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/common/voucher_pending_card.widget.dart';
import 'package:gifthub/presentation/notification_list/notification_list.view.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/user_info/user_info.view.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.notifier.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.state.dart';
import 'package:gifthub/utility/navigator.dart';

class VoucherListView extends ConsumerWidget {
  static const double padding = 10;

  const VoucherListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
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
          onPressed: () => navigate(const NotificationListView()),
          icon: const Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voucherListStateProvider);
    return state.when(
      data: (state) => state.vouchers.isEmpty
          ? _buildEmpty(context, state)
          : _buildData(context, ref, state),
      loading: () => const Loading(),
      error: (error, stackTrace) =>
          _buildError(context, ref, error, stackTrace),
    );
  }

  Widget _buildEmpty(BuildContext context, VoucherListState state) {
    return Center(
      child: Column(
        children: [
          _buildHeader(context, state),
          const Empty('사용할 수 있는 기프티콘이 없습니다.'),
        ],
      ),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
    VoucherListState state,
  ) {
    final subTitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        );
    final listItems = <Widget>[
      _buildHeader(context, state),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Text(
          '보유 브랜드 목록',
          style: subTitleStyle,
        ),
      ),
      _buildBrandFilter(context, ref, state),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Text(
          '보유 기프티콘 목록',
          style: subTitleStyle,
        ),
      ),
      ...List.generate(
        state.pendingCount,
        (index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: VoucherPendingCard(),
        ),
      ),
      ...state.vouchers.map(
        (voucher) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: VoucherCard(voucher.id),
        ),
      ),
    ];
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      itemCount: listItems.length,
      itemBuilder: (BuildContext context, int index) => listItems[index],
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: padding);
      },
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

  Widget _buildHeader(
    BuildContext context,
    VoucherListState state,
  ) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(padding * 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(padding * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('안녕하세요.'),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(4),
                        ),
                        onPressed: () => navigate(UserInfoView()),
                        child: Row(
                          children: [
                            Text(
                              '${state.appUser.nickname}님',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withAlpha(128),
                                    decorationThickness: 8,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  WordBreakText(
                    '만료 예정 기프티콘을 확인하세요!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 0,
              child: Image.asset('assets/icon-circle.png'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandFilter(
    BuildContext context,
    WidgetRef ref,
    VoucherListState state,
  ) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.brands.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 || index == state.brands.length + 1) {
            return Container();
          }
          return _buildBrandCard(context, ref, state.brands[index - 1]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: padding);
        },
      ),
    );
  }

  Widget _buildBrandCard(
    BuildContext context,
    WidgetRef ref,
    Brand brand,
  ) {
    return SizedBox(
      width: 130,
      height: 180,
      child: Card(
        margin: EdgeInsets.zero,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                brand.logoUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text(brand.name),
            ],
          ),
        ),
      ),
    );
  }
}
