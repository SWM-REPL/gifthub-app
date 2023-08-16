// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';

class VoucherEditorContent extends ConsumerStatefulWidget {
  const VoucherEditorContent(
    this.vpb, {
    super.key,
  });

  final VPB vpb;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherEditorContentState();
}

class _VoucherEditorContentState extends ConsumerState<VoucherEditorContent> {
  void onDeletePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('삭제 버튼이 클릭되었습니다.'), // TODO
      ),
    );
  }

  void onSavePressed(
    BuildContext context,
    List<TextEditingController> controllers,
  ) {
    final vpbNotifier = ref.read(vpbProvider(widget.vpb.voucher.id).notifier);
    vpbNotifier.editVoucher(
      brandName: controllers[0].text,
      productName: controllers[1].text,
      expiresAt: DateFormat('yyyy.MM.dd').parse(controllers[2].text),
      barcode: controllers[3].text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    final labels = [
      '브랜드명',
      '상품명',
      '만료일자',
      '바코드',
    ];
    final placeholders = [
      widget.vpb.brand.name,
      widget.vpb.product.name,
      DateFormat('yyyy.MM.dd').format(widget.vpb.voucher.expiredDate),
      widget.vpb.voucher.barcode,
    ];
    final controllers =
        placeholders.map((text) => TextEditingController(text: text)).toList();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: MediaQuery.of(context).padding.add(
              const EdgeInsets.all(20),
            ),
        child: Form(
          child: Column(
            children: [
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.vpb.brand.name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        widget.vpb.product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        NumberFormat.currency(
                          locale: 'ko',
                          customPattern: '#,###원',
                        ).format(widget.vpb.product.price),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 45),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => _buildTextFormField(
                            context: context,
                            label: labels[index],
                            controller: controllers[index],
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                          ),
                          itemCount: labels.length,
                        ),
                      )
                    ],
                  ),
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
                        onPressed: () => onSavePressed(context, controllers),
                        child: const Text('저장'),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextFormField({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
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
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: Theme.of(context).textTheme.bodySmall,
            border: InputBorder.none,
          ),
        ),
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
