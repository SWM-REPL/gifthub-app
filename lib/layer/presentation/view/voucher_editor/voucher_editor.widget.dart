// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.view.dart';

class VoucherEditor extends StatelessWidget {
  const VoucherEditor({
    super.key,
    required this.voucher,
    required this.product,
    required this.brand,
  });

  final Brand brand;
  final Product product;
  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: Center(
        child: VoucherEditorView(
          brand: brand,
          product: product,
          voucher: voucher,
        ),
      ),
    );
  }
}
