// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.view.dart';

class VoucherEditor extends StatelessWidget {
  const VoucherEditor({
    this.voucherId,
    super.key,
  });

  final int? voucherId;

  @override
  Widget build(BuildContext context) {
    return VoucherEditorView(voucherId: voucherId);
  }
}
