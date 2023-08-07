import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

class VoucherCard extends ConsumerStatefulWidget {
  const VoucherCard({required this.voucher, super.key});

  final Voucher voucher;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoucherCardState();
}

class _VoucherCardState extends ConsumerState<VoucherCard> {
  @override
  Widget build(BuildContext context) {
    final expiredDate = widget.voucher.expiredDate;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
                  widget.voucher.imageUrl!,
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
                      children: [
                        Text(
                          widget.voucher.name!,
                          style: Theme.of(context).textTheme.titleMedium,
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
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${NumberFormat('#,##0', 'en-US').format(widget.voucher.price)}원',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${expiredDate.year}년 ${expiredDate.month}월 ${expiredDate.day}일 까지',
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
