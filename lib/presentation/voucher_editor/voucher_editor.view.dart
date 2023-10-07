// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/labeled_text_field.widget.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/utility/format_string.dart';
import 'package:gifthub/utility/navigator.dart';

class VoucherEditorView extends ConsumerStatefulWidget {
  final int? id;

  final formKey = GlobalKey<FormState>();
  final brandNameController = TextEditingController();
  final productNameController = TextEditingController();
  final expiresAtController = TextEditingController();
  final barcodeController = TextEditingController();

  VoucherEditorView({
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
    this.id,
    super.key,
  }) {
    if (id == null) {
      return;
    }
    brandNameController.text = brandName ?? '';
    productNameController.text = productName ?? '';
    expiresAtController.text = expiresAt != null ? dateFormat(expiresAt) : '';
    barcodeController.text = barcode ?? '';
  }

  @override
  ConsumerState<VoucherEditorView> createState() => _VoucherEditorViewState();
}

class _VoucherEditorViewState extends ConsumerState<VoucherEditorView> {
  bool showDataPicker = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: MediaQuery.of(context).viewInsets.add(
                  const EdgeInsets.all(20),
                ),
            child: Column(
              children: [
                LabeledTextField(
                  labelText: '브랜드명',
                  controller: widget.brandNameController,
                ),
                const Divider(),
                LabeledTextField(
                  labelText: '상품명',
                  controller: widget.productNameController,
                ),
                const Divider(),
                TapRegion(
                  onTapInside: (event) {
                    setState(() => showDataPicker = true);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onTapOutside: (event) {
                    setState(() => showDataPicker = false);
                  },
                  child: Column(
                    children: [
                      LabeledTextField(
                        labelText: '만료일자',
                        controller: widget.expiresAtController,
                      ),
                      if (showDataPicker)
                        SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.tryParse(
                                    widget.expiresAtController.text) ??
                                DateTime.now(),
                            onDateTimeChanged: (value) {
                              widget.expiresAtController.text =
                                  dateFormat(value);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(),
                LabeledTextField(
                  labelText: '바코드',
                  controller: widget.barcodeController,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (widget.formKey.currentState!.validate() == false) {
                  return;
                }

                if (widget.id == null) {
                  await ref.watch(createVoucherByValuesCommandProvider)(
                    barcode: widget.barcodeController.text,
                    expiresAt: DateTime.tryParse(
                      widget.expiresAtController.text,
                    )!,
                    productName: widget.productNameController.text,
                    brandName: widget.brandNameController.text,
                  );
                  ref.invalidate(voucherIdsProvider);
                } else {
                  await ref.watch(updateVoucherCommandProvider)(
                    id: widget.id!,
                    barcode: widget.barcodeController.text,
                    expiresAt: DateTime.tryParse(
                      widget.expiresAtController.text,
                    )!,
                    productName: widget.productNameController.text,
                    brandName: widget.brandNameController.text,
                  );
                  ref.invalidate(voucherProvider(widget.id!));
                }
                navigateBack();
              },
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    padding: MaterialStateProperty.resolveWith(
                      (states) => MediaQuery.of(context).padding.add(
                            const EdgeInsets.only(
                              top: 10,
                            ),
                          ),
                    ),
                  ),
              child: const Text('저장'),
            ),
          )
        ],
      ),
    );
  }
}
