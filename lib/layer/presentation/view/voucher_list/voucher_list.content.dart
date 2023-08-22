// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_break_text/word_break_text.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/components/voucher_card.dart';

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
    final cards = widget.vpbs.map(
      (vpb) => VoucherCard(
        vpb,
        usable: vpb.voucher.isUsable,
      ),
    );

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
                            style: Theme.of(context).textTheme.titleSmall,
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
                                  fontWeight: FontWeight.bold,
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
          const SizedBox(
            height: 15,
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).padding.left + 20,
                right: MediaQuery.of(context).padding.right + 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '보유 기프티콘 목록',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: widget.vpbs.length,
                      itemBuilder: (context, index) => cards.elementAt(index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
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
