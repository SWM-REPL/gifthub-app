// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_break_text/word_break_text.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/components/brand_list.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/components/voucher_list.dart';

class VoucherListContent extends ConsumerStatefulWidget {
  const VoucherListContent(
    this.vpbs, {
    super.key,
  });

  final List<VPB> vpbs;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherListContentState();
}

class _VoucherListContentState extends ConsumerState<VoucherListContent> {
  @override
  Widget build(BuildContext context) {
    final appuser = ref.watch(appUserProvider);

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '안녕하세요. ${appuser.asData?.value.nickname}님',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          WordBreakText(
                            '만료 예정 기프티콘을 확인하세요!',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
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
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).padding.left + 20,
                right: MediaQuery.of(context).padding.right + 20,
              ),
              child: widget.vpbs.any((vpb) => vpb.voucher.isUsable)
                  ? ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '보유 브랜드 목록',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const BrandList(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '보유 기프티콘 목록',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const VoucherList(),
                      ],
                    )
                  : Column(
                      children: [
                        Image.asset(
                          'assets/icon.png',
                          color: Theme.of(context).disabledColor,
                        ),
                        AutoSizeText(
                          '사용할 수 있는 기프티콘이 없습니다.',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
