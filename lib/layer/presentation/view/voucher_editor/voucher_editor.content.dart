// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

class VoucherEditorContent extends ConsumerStatefulWidget {
  const VoucherEditorContent({
    required this.brand,
    required this.product,
    required this.voucher,
    super.key,
  });

  final Brand brand;
  final Product product;
  final Voucher voucher;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherEditorContentState();
}

class _VoucherEditorContentState extends ConsumerState<VoucherEditorContent> {
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
      widget.brand.name,
      widget.product.name,
      DateFormat('yyyy.MM.dd').format(widget.voucher.expiredDate),
      widget.voucher.barcode,
    ];

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
                        '스타벅스',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '아이스 카페 아메리카노',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '18,500원',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 45),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => _buildTextFormField(
                            context: context,
                            label: labels[index],
                            placeholder: placeholders[index],
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
                      onPressed: () {},
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
                        onPressed: () {},
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
  required String placeholder,
}) {
  final controller = TextEditingController(text: placeholder);
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
