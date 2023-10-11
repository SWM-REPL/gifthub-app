// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';

class VoucherPendingCard extends StatelessWidget {
  static const double height = VoucherCard.height;
  static const double padding = VoucherCard.padding;

  const VoucherPendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SizedBox(
          height: height,
          child: Loading(),
        ),
      ),
    );
  }
}
