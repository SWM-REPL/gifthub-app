// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/providers/product.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher/voucher.screen.dart';
import 'package:gifthub/theme/constant.theme.dart';
import 'package:gifthub/utility/navigator.dart';

class VoucherCard extends ConsumerWidget {
  static const padding = GiftHubConstants.padding;
  static const height = 80.0;

  final int id;

  const VoucherCard(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucher = ref.watch(voucherProvider(id));
    return voucher.when(
      data: (voucher) {
        final product = ref.watch(productProvider(voucher.productId));
        return product.when(
          data: (product) => _buildData(context, ref, voucher, product),
          loading: () => const Loading(),
          error: (error, stackTrace) =>
              _buildError(context, ref, error, stackTrace),
        );
      },
      loading: () => const Loading(),
      error: (error, stackTrace) =>
          _buildError(context, ref, error, stackTrace),
    );
  }

  Widget _buildData(
    BuildContext context,
    WidgetRef ref,
    Voucher voucher,
    Product product,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
      opacity: voucher.isUsable ? 1 : 0.5,
      child: Card(
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () => navigate(
            VoucherScreen(
              voucherId: voucher.id,
              productId: product.id,
              brandId: product.brandId,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    width: height,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: padding),
                Flexible(
                  child: SizedBox(
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          product.name,
                          style: textTheme.bodyLarge,
                          maxLines: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.isReusable ? product.priceFormatted : '',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: padding / 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  voucher.balanceFormatted,
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  voucher.expiresAtFormatted,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: voucher.aboutToExpire
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Card(
      child: Text(error.toString()),
    );
  }
}
