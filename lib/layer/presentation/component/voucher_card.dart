// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherCard extends ConsumerWidget {
  VoucherCard(
    VPB vpb, {
    super.key,
  })  : voucher = vpb.voucher,
        product = vpb.product;

  final Voucher voucher;
  final Product product;

  void openVoucherDetail(BuildContext context) {
    navigate(
      VoucherDetail(voucher.id),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difference = voucher.expiredDate
        .difference(DateTime.now().copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ))
        .inDays;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Opacity(
          opacity: voucher.isUsable ? 1 : 0.5,
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => openVoucherDetail(context),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          fit: BoxFit.cover,
                          product.imageUrl,
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
                                    product.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${NumberFormat('#,##0', 'en-US').format(voucher.balance)}원',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  (difference == 0)
                                      ? '오늘 만료'
                                      : (difference > 0 && difference <= 5)
                                          ? '$difference일 남음'
                                          : '${voucher.expiredDate.year}년 ${voucher.expiredDate.month}월 ${voucher.expiredDate.day}일 까지',
                                  style: (difference <= 5 && difference >= 0)
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.red,
                                          )
                                      : Theme.of(context).textTheme.bodySmall,
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
            ),
          ),
        ),
      ],
    );
  }
}
