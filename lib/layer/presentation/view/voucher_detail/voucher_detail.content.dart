// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

class VoucherDetailContent extends ConsumerStatefulWidget {
  const VoucherDetailContent({
    required this.voucher,
    required this.product,
    super.key,
  });

  final Voucher voucher;
  final Product product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherDetailContentState();
}

class _VoucherDetailContentState extends ConsumerState<VoucherDetailContent> {
  @override
  Widget build(BuildContext context) {
    final voucher = widget.voucher;
    final product = widget.product;

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '${product.price}원',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.network(
                'https://barcode.tec-it.com/barcode.ashx?data=${voucher.barcode}&translate-esc=on&imagetype=Png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
