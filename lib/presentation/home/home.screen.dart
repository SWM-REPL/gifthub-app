// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/domain/exceptions/device_offline.exception.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/placeholder_icon.widget.dart';
import 'package:gifthub/presentation/editor/editor.screen.dart';
import 'package:gifthub/presentation/home/home.state.dart';
import 'package:gifthub/presentation/home/home_brands.widget.dart';
import 'package:gifthub/presentation/home/home_header.widget.dart';
import 'package:gifthub/presentation/notifications/notifications.screen.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/notification.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/tutorial/tutorial.screen.dart';
import 'package:gifthub/presentation/voucher/voucher_card.widget.dart';
import 'package:gifthub/presentation/voucher/voucher_pending_card.widget.dart';
import 'package:gifthub/utility/navigator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const double padding = GiftHubConstants.padding;
  double bottomPadding = 0;
  double rightPadding = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _buildAppBar(context, ref),
      body: _buildBody(context, ref),
      floatingActionButton: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            bottomPadding = max(0, bottomPadding - details.delta.dy);
            rightPadding = max(0, rightPadding - details.delta.dx);
          });
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: rightPadding,
            bottom: bottomPadding,
          ),
          child: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            backgroundColor: colorScheme.primary,
            spacing: padding,
            children: [
              SpeedDialChild(
                onTap: () => showModal(EditorScreen()),
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.primary,
                label: '텍스트로 등록하기',
                child: const Icon(Icons.notes),
              ),
              SpeedDialChild(
                onTap: () async {
                  final images = await ImagePicker().pickMultiImage();
                  await Future.wait(images.map(
                    (image) => ref.watch(
                      createVoucherByImageCommandProvider(image.path),
                    )(),
                  ));
                  ref.invalidate(voucherIdsProvider);
                  ref.invalidate(pendingCountProvider);
                },
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.primary,
                label: '이미지로 등록하기',
                child: const Icon(Icons.image),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
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
          onPressed: () {
            ref.watch(notificationsProvider.notifier).markAllAsRead();
            navigate(const NotificationsScreen());
          },
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                size: 24,
              ),
              ref.watch(notificationCountProvider).when(
                    data: (count) => count == 0
                        ? const SizedBox()
                        : Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                    loading: () => const SizedBox(),
                    error: (error, stacktrace) => const SizedBox(),
                  ),
            ],
          ),
        ),
      ],
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
          PlaceholderIcon('사용할 수 있는 기프티콘이 없습니다'),
          AutoSizeText(
            '오른쪽 하단의 기프티콘 추가하기 버튼을 이용해보세요',
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final vouchers = ref.watch(vouchersProvider);
    final pendingCount = ref.watch(pendingCountProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(voucherIdsProvider);
        ref.invalidate(pendingCountProvider);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        children: [
          const HomeHeader(),
          vouchers.when(
            data: (v) => pendingCount.when(
              data: (count) => count == 0 && v.isEmpty
                  ? _buildEmpty(context, ref)
                  : _buildData(context, ref),
              loading: () => const Loading(),
              error: (error, stacktrace) =>
                  _buildError(context, ref, error, stacktrace),
            ),
            loading: () => const Loading(),
            error: (error, stacktrace) =>
                _buildError(context, ref, error, stacktrace),
          ),
        ],
      ),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
  ) {
    final brands = ref.watch(brandsProvider);
    final pendingCount = ref.watch(pendingCountProvider);
    final filteredVoucher = ref.watch(filteredVouchersProvider);
    final listItems = <Widget>[
      ...brands.when(
        data: (b) => b.isEmpty
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Text(
                    '보유 브랜드 목록',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
                const HomeBrands()
              ],
        loading: () => [],
        error: (error, stacktrace) => [],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Text(
          '보유 기프티콘 목록',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      ),
      ...pendingCount.when(
        data: (count) => List.generate(
          count,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: VoucherPendingCard(),
          ),
        ),
        loading: () => [],
        error: (error, stacktrace) => [],
      ),
      ...filteredVoucher.when(
        data: (v) => v.map(
          (v) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: VoucherCard(v.id),
          ),
        ),
        loading: () => [],
        error: (error, stacktrace) => [],
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listItems
          .map((i) => [i, const SizedBox(height: padding)])
          .expand((i) => i)
          .toList()
        ..removeLast(),
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
