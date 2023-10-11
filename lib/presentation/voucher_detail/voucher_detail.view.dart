// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/voucher_detail/voucher_detail.notifier.dart';
import 'package:gifthub/presentation/voucher_detail/voucher_detail.state.dart';
import 'package:gifthub/presentation/voucher_editor/voucher_editor.view.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class VoucherDetailView extends ConsumerWidget {
  final int id;

  const VoucherDetailView(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(
        context,
        ref,
      ),
      extendBodyBehindAppBar: true,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voucherDetailStateProvider(id));
    return state.when(
      data: (data) => _buildData(context, ref, data),
      loading: () => const Loading(),
      error: (error, stackTrace) =>
          _buildError(context, ref, error, stackTrace),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
    VoucherDetailState state,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Opacity(
                  opacity: state.voucher.isUsable ? 1 : 0.5,
                  child: Image.network(state.product.imageUrl,
                      fit: BoxFit.fitWidth),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          state.brand.name,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.product.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.voucher.balanceFormatted,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20),
                        _buildButtons(context, ref, state),
                        const SizedBox(height: 30),
                        if (state.product.description != null)
                          Text(
                            state.product.description!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.all(10).copyWith(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: 48,
                  height: 48,
                ),
                child: ElevatedButton(
                  onPressed: () => _onDeletePressed(context, ref),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: const Icon(Icons.delete_forever_outlined),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _onUsePressed(ref),
                  child: const SizedBox(
                      height: 48, child: Center(child: Text('사용하기'))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref,
    Object error,
    StackTrace? stackTrace,
  ) {
    throw error;
  }

  Widget _buildButtons(
    BuildContext context,
    WidgetRef ref,
    VoucherDetailState state,
  ) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _onImageSavePressed(ref),
            icon: const Icon(
              Icons.file_download_outlined,
              color: Colors.grey,
            ),
            label: Text(
              '이미지 저장',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () => _onEditPressed(ref, state),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.grey,
                ),
                label: Text(
                  '수정하기',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              TextButton.icon(
                onPressed: () => _onSharePressed(ref),
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.grey,
                ),
                label: Text(
                  '공유하기',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }

  void _onImageSavePressed(WidgetRef ref) {
    showSnackBar(const Text('준비 중입니다.'));
  }

  void _onEditPressed(
    WidgetRef ref,
    VoucherDetailState state,
  ) {
    showModal(VoucherEditorView(
      id: id,
      brandName: state.brand.name,
      productName: state.product.name,
      expiresAt: state.voucher.expiresAt,
      barcode: state.voucher.barcode,
    ));
  }

  void _onSharePressed(WidgetRef ref) {
    showSnackBar(const Text('준비 중입니다.'));
  }

  void _onDeletePressed(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '삭제하시겠습니까?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(voucherDetailStateProvider(id).notifier)
                          .delete();
                      navigateBack(count: 2);
                    },
                    child: const Text('삭제하기'),
                  ),
                  TextButton(
                    onPressed: () => navigateBack(),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: const Text('취소하기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onUsePressed(WidgetRef ref) {
    showSnackBar(const Text('준비 중입니다.'));
  }
}
