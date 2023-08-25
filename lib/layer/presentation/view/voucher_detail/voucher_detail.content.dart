// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherDetailContent extends ConsumerStatefulWidget {
  VoucherDetailContent(
    VPB data, {
    super.key,
  })  : voucher = data.voucher,
        product = data.product,
        brand = data.brand;

  final Voucher voucher;
  final Product product;
  final Brand brand;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherDetailContentState();
}

class _VoucherDetailContentState extends ConsumerState<VoucherDetailContent> {
  final amountFormKey = GlobalKey<FormState>();
  bool usable = true;

  void _onSavePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('저장 버튼이 클릭되었습니다.'), // TODO
      ),
    );
  }

  void _onEditPressed(BuildContext context) {
    navigate(
      context: context,
      widget: VoucherEditor(voucherId: widget.voucher.id),
      bottomModal: true,
    );
  }

  void _onSharePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('공유 버튼이 클릭되었습니다.'), // TODO
      ),
    );
  }

  void _onUsePressed(BuildContext context) {
    if (widget.product.isReusable) {
      navigate(
        context: context,
        widget: _AmountSheet(
          formKey: amountFormKey,
          voucher: widget.voucher,
          onUsePressed: _useVoucher,
        ),
        bottomModal: true,
      );
    } else {
      _useVoucher(context, widget.product.price);
    }
  }

  void _useVoucher(BuildContext context, int amount) {
    if (widget.product.isReusable &&
        amountFormKey.currentState!.validate() == false) {
      return;
    }

    final vpbNotifier = ref.read(vpbProvider(widget.voucher.id).notifier);
    vpbNotifier.useVoucher(amount).then((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사용되었습니다.'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.voucher.balance == 0) {
      setState(() => usable = false);
    }
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: AspectRatio(
            aspectRatio: 2 / 1,
            child: Opacity(
              opacity: usable ? 1 : 0.5,
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Column(
                  children: [
                    Text(
                      widget.brand.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '${widget.product.price}원',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '잔액: ${widget.voucher.balance}원',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                      'https://barcode.tec-it.com/barcode.ashx?data=${widget.voucher.barcode}',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const InProgress();
                        }
                      },
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _onSavePressed(context),
                            icon: const Icon(
                              Icons.file_download,
                              color: Colors.grey,
                            ),
                            label: const Text(
                              '이미지 저장',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.resolveWith<EdgeInsets>(
                                (states) => const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: () => _onEditPressed(context),
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                label: const Text(
                                  '수정하기',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const VerticalDivider(),
                              TextButton.icon(
                                onPressed: () => _onSharePressed(context),
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                ),
                                label: const Text(
                                  '공유하기',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        '유의사항',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.product.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  widget.voucher.isUsable ? () => _onUsePressed(context) : null,
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                  (states) => const EdgeInsets.only(
                    top: 16,
                    bottom: 36,
                  ),
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              child: const Text('사용하기'),
            ),
          ),
        ),
      ],
    );
  }
}

class _AmountSheet extends StatelessWidget {
  const _AmountSheet({
    required this.formKey,
    required this.voucher,
    required this.onUsePressed,
  });

  final GlobalKey<FormState> formKey;
  final Voucher voucher;
  final void Function(BuildContext, int) onUsePressed;

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(
            const EdgeInsets.all(20),
          ),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '사용할 금액을 입력해주세요',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '잔액: ${voucher.balance}원',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              autofocus: true,
              validator: (value) =>
                  (int.tryParse(value ?? '0') ?? 0) > voucher.balance
                      ? '잔액(${voucher.balance}원) 이하로 입력해주세요'
                      : null,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => onUsePressed(
                  context,
                  int.parse(amountController.text),
                ),
                child: const Text('사용하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
