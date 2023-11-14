// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/voucher/voucher_card.widget.dart';

class VoucherPendingCard extends StatefulWidget {
  static const double height = VoucherCard.height;
  static const double padding = VoucherCard.padding;

  const VoucherPendingCard({super.key});

  @override
  State<VoucherPendingCard> createState() => _VoucherPendingCardState();
}

class _VoucherPendingCardState extends State<VoucherPendingCard> {
  late final Timer timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds = timer.tick;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(VoucherPendingCard.padding),
        child: SizedBox(
          height: VoucherPendingCard.height,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const Loading(size: VoucherPendingCard.height),
              const SizedBox(width: VoucherPendingCard.padding),
              Flexible(
                flex: 1,
                child: Text(
                  '라쿤이가 열심히 일하고 있습니다${'.' * (_seconds % 3 + 1)}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
