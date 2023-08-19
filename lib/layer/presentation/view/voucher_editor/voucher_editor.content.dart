// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';

class VoucherEditorContent extends ConsumerStatefulWidget {
  VoucherEditorContent({
    VPB? data,
    super.key,
  })  : voucher = data?.voucher,
        product = data?.product,
        brand = data?.brand;

  final Voucher? voucher;
  final Product? product;
  final Brand? brand;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherEditorContentState();
}

class _VoucherEditorContentState extends ConsumerState<VoucherEditorContent> {
  late TextEditingController brandNameController;
  late TextEditingController productNameController;
  late TextEditingController expiresAtController;
  late TextEditingController barcodeController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showDatePicker = false;

  void onDeletePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('삭제 버튼이 클릭되었습니다.'), // TODO
      ),
    );
  }

  void onSavePressed(
    BuildContext context,
  ) {
    if (widget.voucher == null) {
    } else {
      final vpbNotifier = ref.read(vpbProvider(widget.voucher!.id).notifier);
      vpbNotifier.editVoucher(
        brandName: brandNameController.text,
        productName: productNameController.text,
        expiresAt: DateTime.tryParse(expiresAtController.text),
        barcode: barcodeController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    brandNameController = TextEditingController(
      text: widget.brand?.name ?? '',
    );
    productNameController = TextEditingController(
      text: widget.product?.name ?? '',
    );
    expiresAtController = TextEditingController(
      text: DateFormat('yyyy.MM.dd')
          .format(widget.voucher?.expiredDate ?? DateTime.now()),
    );
    barcodeController = TextEditingController(
      text: widget.voucher?.barcode ?? '',
    );

    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(
            MediaQuery.of(context).padding.add(
                  const EdgeInsets.symmetric(horizontal: 20),
                ),
          ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  _wrapTextField(
                    context: context,
                    label: '브랜드명',
                    child: TextField(
                      controller: brandNameController,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  _wrapTextField(
                    context: context,
                    label: '상품명',
                    child: TextField(
                      controller: productNameController,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  TapRegion(
                    onTapInside: (event) {
                      setState(() => showDatePicker = true);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onTapOutside: (event) =>
                        setState(() => showDatePicker = false),
                    child: Column(
                      children: [
                        _wrapTextField(
                          context: context,
                          label: '만료일자',
                          child: TextField(
                            controller: expiresAtController,
                            enabled: false,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (showDatePicker)
                          SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime value) {
                                expiresAtController.value = TextEditingValue(
                                  text: DateFormat('yyyy.MM.dd').format(value),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  _wrapTextField(
                    context: context,
                    label: '바코드',
                    child: TextField(
                      controller: barcodeController,
                      style: Theme.of(context).textTheme.bodyLarge,
                      enableInteractiveSelection: false,
                      showCursor: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => onDeletePressed(context),
                    child: Icon(
                      Icons.delete_outline,
                      color: secondaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => onSavePressed(context),
                      child: const Text('저장'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapTextField({
    required BuildContext context,
    required String label,
    required TextField child,
  }) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Flexible(
          flex: 7,
          child: child,
        ),
        Flexible(
          flex: 1,
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
