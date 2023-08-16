// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.content.dart';

class VoucherEditorView extends ConsumerStatefulWidget {
  const VoucherEditorView(
    this.voucherId, {
    super.key,
  });

  final int voucherId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherEditorViewState();
}

class _VoucherEditorViewState extends ConsumerState<VoucherEditorView> {
  @override
  Widget build(BuildContext context) {
    final vpb = ref.watch(vpbProvider(widget.voucherId));
    return vpb.when(
      data: (data) => VoucherEditorContent(data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => throw error,
    );
  }
}
