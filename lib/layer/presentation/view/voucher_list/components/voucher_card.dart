// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherCard extends ConsumerStatefulWidget {
  const VoucherCard(
    this.vpb, {
    super.key,
  });

  final VPB vpb;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoucherCardState();
}

class _VoucherCardState extends ConsumerState<VoucherCard> {
  void openVoucherDetail(BuildContext context) {
    navigate(
      context: context,
      widget: VoucherDetail(widget.vpb.voucher.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openVoucherDetail(context),
      child: Container(
        height: 112,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  fit: BoxFit.cover,
                  widget.vpb.product.imageUrl,
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            widget.vpb.product.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFAE36F7),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 12,
                            ),
                            child: Text(
                              'NEW',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${NumberFormat('#,##0', 'en-US').format(widget.vpb.voucher.balance)}원',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${widget.vpb.voucher.expiredDate.year}년 ${widget.vpb.voucher.expiredDate.month}월 ${widget.vpb.voucher.expiredDate.day}일 까지',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
