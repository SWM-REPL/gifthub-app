// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher/voucher_barcode.screen.dart';
import 'package:gifthub/presentation/voucher/voucher_buttons.widget.dart';
import 'package:gifthub/utility/format_string.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';

class VoucherScreen extends ConsumerStatefulWidget {
  final int voucherId;
  final int productId;
  final int brandId;

  final amountController = TextEditingController();

  VoucherScreen({
    required this.voucherId,
    required this.productId,
    required this.brandId,
    super.key,
  });

  @override
  ConsumerState<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends ConsumerState<VoucherScreen> {
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
      if (!v.isChecked) {
        showConfirm(
          title: const Text('🦝 미숙한 라쿤이 이슈'),
          content: const Text('아직 라쿤이가 많이 미숙해요!\n등록된 정보가 이미지와 일치하는지 꼭 확인해주세요.'),
          onConfirmPressed: () {},
        );
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
                        VoucherButtons(
                          voucherId: widget.voucherId,
                          productId: widget.productId,
                          brandId: widget.brandId,
                        ),
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
        showModal(VoucherBarcodeScreen(voucher.barcode ?? ''));
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
}
