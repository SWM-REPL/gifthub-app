// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.view.dart';

class VoucherEditor extends StatelessWidget {
  const VoucherEditor(
    this.vpb, {
    super.key,
  });

  final VPB vpb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VoucherEditorView(vpb),
      ),
    );
  }
}
