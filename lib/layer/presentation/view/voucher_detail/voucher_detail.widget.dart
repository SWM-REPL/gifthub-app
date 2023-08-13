// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.view.dart';

class VoucherDetail extends StatelessWidget {
  const VoucherDetail({
    required this.voucher,
    required this.product,
    super.key,
  });

  final Voucher voucher;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VoucherDetailView(
          voucher: voucher,
          product: product,
        ),
      ),
    );
  }
}
