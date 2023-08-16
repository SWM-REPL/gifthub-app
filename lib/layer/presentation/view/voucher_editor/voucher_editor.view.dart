// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.content.dart';

class VoucherEditorView extends ConsumerStatefulWidget {
  const VoucherEditorView(
    this.vpb, {
    super.key,
  });

  final VPB vpb;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherEditorViewState();
}

class _VoucherEditorViewState extends ConsumerState<VoucherEditorView> {
  @override
  Widget build(BuildContext context) {
    return VoucherEditorContent(widget.vpb);
  }
}
