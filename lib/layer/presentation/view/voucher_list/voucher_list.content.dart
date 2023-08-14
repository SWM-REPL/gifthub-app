// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_list/components/voucher_card.dart';

class VoucherListContent extends ConsumerStatefulWidget {
  const VoucherListContent({
    required this.voucherIds,
    super.key,
  });

  final List<int> voucherIds;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherListContentState();
}

class _VoucherListContentState extends ConsumerState<VoucherListContent> {
  @override
  Widget build(BuildContext context) {
    final ids = widget.voucherIds;
    return Container(
      color: const Color(0xFFF7F8FA),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.grey,
            ),
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
                  Text(
                    '보유 기프티콘 목록',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: ids.length,
                      itemBuilder: (context, index) => VoucherCard(
                        voucherId: ids[index],
                      ),
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
