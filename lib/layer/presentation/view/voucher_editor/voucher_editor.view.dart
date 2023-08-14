// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.content.dart';

class VoucherEditorView extends ConsumerStatefulWidget {
  const VoucherEditorView({
    required this.voucher,
    required this.product,
    required this.brand,
    super.key,
  });

  final Brand brand;
  final Product product;
  final Voucher voucher;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherEditorViewState();
}

class _VoucherEditorViewState extends ConsumerState<VoucherEditorView> {
  @override
  Widget build(BuildContext context) {
    return VoucherEditorContent(
      brand: widget.brand,
      product: widget.product,
      voucher: widget.voucher,
    );
  }
}
