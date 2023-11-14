// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/labeled_text_field.widget.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/utility/format_string.dart';
import 'package:gifthub/utility/navigator.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final int? voucherId;
  final int? productId;
  final int? brandId;

  final formKey = GlobalKey<FormState>();
  final brandNameController = TextEditingController();
  final productNameController = TextEditingController();
  final expiresAtController = TextEditingController();
  final barcodeController = TextEditingController();
  final balanceController = TextEditingController();

  EditorScreen({
    this.voucherId,
    this.productId,
    this.brandId,
    super.key,
  });

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  bool showBalance = false;
  bool showDataPicker = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadInfo);
  }

  void _loadInfo() async {
    if (widget.voucherId != null &&
        widget.productId != null &&
        widget.brandId != null) {
      final voucher = await ref.read(voucherProvider(widget.voucherId!).future);
      final product = await ref.read(productProvider(widget.productId!).future);
      final brand = await ref.read(brandProvider(widget.brandId!).future);

      widget.brandNameController.text = brand.name;
      widget.productNameController.text = product.name;
      widget.expiresAtController.text = dateFormat(voucher.expiresAt);
      widget.barcodeController.text = voucher.barcode ?? '';
      widget.balanceController.text = voucher.balance.toString();

      setState(() {
        showBalance = product.isReusable;
      });
    }
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
                        enabled: false,
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
                if (showBalance) const Divider(),
                if (showBalance)
                  LabeledTextField(
                    labelText: '잔액',
                    controller: widget.balanceController,
                    keyboardType: TextInputType.number,
                  ),
                const Divider(),
                LabeledTextField(
                  labelText: '바코드',
                  controller: widget.barcodeController,
                  keyboardType: TextInputType.number,
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

                if (widget.voucherId != null) {
                  await ref
                      .watch(updateVoucherCommandProvider(widget.voucherId!))(
                    barcode: widget.barcodeController.text,
                    balance: int.tryParse(widget.balanceController.text),
                    expiresAt: DateTime.tryParse(
                      widget.expiresAtController.text,
                    )!,
                    productName: widget.productNameController.text,
                    brandName: widget.brandNameController.text,
                  );
                  ref.invalidate(voucherProvider(widget.voucherId!));
                } else {
                  await ref.watch(createVoucherByValuesCommandProvider)(
                    barcode: widget.barcodeController.text,
                    expiresAt: DateTime.tryParse(
                      widget.expiresAtController.text,
                    )!,
                    productName: widget.productNameController.text,
                    brandName: widget.brandNameController.text,
                  );
                  ref.invalidate(voucherIdsProvider);
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
