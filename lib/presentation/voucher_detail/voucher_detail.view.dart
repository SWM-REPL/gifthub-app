// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher_detail/voucher_barcode.view.dart';
import 'package:gifthub/presentation/voucher_editor/voucher_editor.widget.dart';
import 'package:gifthub/utility/format_string.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class VoucherDetailView extends ConsumerStatefulWidget {
  final int voucherId;
  final int productId;
  final int brandId;

  final amountController = TextEditingController();
  final messageController = TextEditingController();

  VoucherDetailView({
    required this.voucherId,
    required this.productId,
    required this.brandId,
    super.key,
  });

  @override
  ConsumerState<VoucherDetailView> createState() => _VoucherDetailViewState();
}

class _VoucherDetailViewState extends ConsumerState<VoucherDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
      extendBodyBehindAppBar: true,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final voucher = ref.watch(voucherProvider(widget.voucherId));
    final product = ref.watch(productProvider(widget.productId));
    final brand = ref.watch(brandProvider(widget.brandId));
    voucher.whenData((v) {
      if (!v.isAccessible) {
        showSnackBar(text: '접근할 수 없는 기프티콘입니다.');
        navigateBack();
      }
    });
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Opacity(
                  opacity: voucher.when(
                    data: (v) => v.isUsable ? 1 : 0.5,
                    loading: () => 1,
                    error: (error, stackTrace) => throw error,
                  ),
                  child: product.when(
                    data: (p) => Image.network(
                      p.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                    loading: () => const Loading(),
                    error: (error, stackTrace) => throw error,
                  ),
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
                        brand.when(
                          data: (b) => Text(
                            b.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          loading: () => const Loading(),
                          error: (error, stackTrace) => throw error,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.when(
                            data: (p) => p.name,
                            loading: () => '',
                            error: (error, stackTrace) => throw error,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          voucher.when(
                            data: (v) => v.balanceFormatted,
                            loading: () => '',
                            error: (error, stackTrace) => throw error,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20),
                        _buildButtons(context, ref),
                        const SizedBox(height: 30),
                        product.when(
                          data: (p) => p.description != null
                              ? Text(
                                  p.description!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              : const Text(''),
                          loading: () => const Loading(),
                          error: (error, stackTrace) => throw error,
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
                  onPressed: product.when(
                    data: (product) {
                      return () => _onDeletePressed(context, ref, product);
                    },
                    loading: () => null,
                    error: (error, stackTrace) => null,
                  ),
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
                  onPressed: voucher.when(
                    data: (v) => v.isUsable ? () => _onUsePressed(ref) : null,
                    loading: () => null,
                    error: (error, stackTrace) => null,
                  ),
                  child: const SizedBox(
                    height: 48,
                    child: Center(
                      child: Text('사용하기'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(
    BuildContext context,
    WidgetRef ref,
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
                onPressed: () => _onEditPressed(),
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
    showSnackBar(text: '준비 중입니다.');
  }

  void _onEditPressed() {
    showModal(
      VoucherEditor(
        voucherId: widget.voucherId,
        productId: widget.productId,
        brandId: widget.brandId,
      ),
    );
  }

  void _onSharePressed(WidgetRef ref) async {
    showConfirm(
      title: const Text('기프티콘 공유하기'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('선물이 완료된 기프티콘은 더이상 사용자의 기프티콘 목록에 표시되지 않습니다.'),
          Text(''),
          Text('정말 선물하시겠습니까?'),
        ],
      ),
      onConfirmPressed: () => showConfirm(
        title: const Text('기프티콘 공유하기'),
        content: _buildMessageField(),
        onConfirmPressed: () async {
          final message = widget.messageController.text;
          final giftcard = await ref.watch(
            shareVoucherCommandProvider(
              ShareVoucherParameter(
                voucherId: widget.voucherId,
                message: message,
              ),
            ),
          )();
          Share.share(
            '🎁 선물이 도착했어요 🎁\n\n💌 함께 온 메시지\n$message\n\nhttps://gifthub.kr/giftcards/${giftcard.id}\n\n🔑 비밀번호: ${giftcard.password}',
            subject: '공유 링크 보내기',
          );
        },
      ),
      confirmText: '선물하기',
    );
  }

  void _onDeletePressed(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) async {
    final deleteVoucherCommand = ref.watch(deleteVoucherCommandProvider);
    showConfirm(
      title: const Text('기프티콘 삭제'),
      content: Text('${product.name} 기프티콘을 삭제하시겠습니까?'),
      onConfirmPressed: () async {
        await deleteVoucherCommand(widget.voucherId);
        ref.invalidate(voucherIdsProvider);
        navigateBack();
      },
      confirmText: '삭제하기',
    );
  }

  void _onUsePressed(WidgetRef ref) async {
    final voucher = await ref.watch(voucherProvider(widget.voucherId).future);
    final product = await ref.watch(productProvider(widget.productId).future);

    showConfirm(
      title: const Text('기프티콘 사용'),
      content: product.isReusable
          ? _buildAmountField(voucher.balance)
          : const Text('사용하기 버튼으르 누르면 쿠폰이 바로 나옵니다. 바코드가 외부에 노출되지 않도록 주의해주세요.'),
      onConfirmPressed: () async {
        final amount = int.tryParse(widget.amountController.text);
        await ref.watch(useVoucherCommandProvider)(voucher.id, amount);
        ref.invalidate(voucherProvider(voucher.id));
        showModal(VoucherBarcodeView(voucher.barcode ?? ''));
      },
      confirmText: '사용하기',
    );
  }

  Widget _buildAmountField(int balance) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${currencyFormat(balance)} 중 사용할 금액을 입력해주세요'),
        const SizedBox(height: 50),
        TextFormField(
          controller: widget.amountController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '금액',
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildMessageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('메시지를 입력해주세요'),
        const SizedBox(height: 20),
        TextFormField(
          maxLines: null,
          controller: widget.messageController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '받을 사람에게 보낼 메시지',
          ),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
