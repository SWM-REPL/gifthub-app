// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/domain/entity/product.entity.dart';
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/notifier/brands.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/products.notifier.dart';
import 'package:gifthub/layer/presentation/notifier/vouchers.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_detail/voucher_detail.widget.dart';

class VoucherCard extends ConsumerStatefulWidget {
  const VoucherCard({
    required this.voucherId,
    super.key,
  });

  final int voucherId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoucherCardState();
}

class _VoucherCardState extends ConsumerState<VoucherCard> {
  @override
  Widget build(BuildContext context) {
    final id = widget.voucherId;
    final voucher = ref.watch(voucherProvider(id));

    return voucher.when(
      data: (voucher) {
        final product = ref.watch(productProvider(voucher.productId));
        return product.when(
          data: (product) {
            final brand = ref.watch(brandProvider(product.brandId));
            return brand.when(
              data: (brand) {
                return _VoucherCard(
                  voucher: voucher,
                  product: product,
                  brand: brand,
                );
              },
              loading: () => const Placeholder(),
              error: (error, stackTrace) => Text(error.toString()),
            );
          },
          loading: () => const Placeholder(),
          error: (error, stackTrace) => Text(error.toString()),
        );
      },
      loading: () => const Placeholder(),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({
    required this.voucher,
    required this.product,
    required this.brand,
  });

  final Voucher voucher;
  final Product product;
  final Brand brand;

  void openVoucherDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VoucherDetail(
          voucher: voucher,
          product: product,
          brand: brand,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => openVoucherDetail(context),
        child: Container(
          height: 112,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    fit: BoxFit.cover,
                    product.imageUrl,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFAE36F7),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 12,
                                ),
                                child: Text(
                                  'NEW',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${NumberFormat('#,##0', 'en-US').format(product.price)}원',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '${voucher.expiredDate.year}년 ${voucher.expiredDate.month}월 ${voucher.expiredDate.day}일 까지',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
