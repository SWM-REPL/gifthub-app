// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/home/home.state.dart';
import 'package:gifthub/theme/constant.theme.dart';
import 'package:gifthub/utility/format_string.dart';

class BrandCard extends ConsumerWidget {
  static const padding = GiftHubConstants.padding;

  final Brand brand;

  const BrandCard(this.brand, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandInfo = ref.watch(brandInfoProvider);
    final brandFilter = ref.watch(brandFilterProvider);
    final isSelected = brandFilter?.id == brand.id;
    return GestureDetector(
      onTap: () {
        final brandFilterNotifier = ref.watch(brandFilterProvider.notifier);
        brandFilterNotifier.state = isSelected ? null : brand;
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                brand.logoUrl,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
              AutoSizeText(
                brand.name,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.53846,
                    ),
              ),
              AutoSizeText(
                currencyFormat(
                  brandInfo.when(
                    data: (infos) => infos[brand.id]?.totalBalance,
                    loading: () => null,
                    error: (error, stacktrace) => null,
                  ),
                ),
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.55556,
                    ),
              ),
              Text(
                '${brandInfo.when(
                  data: (infos) => infos[brand.id]?.voucherCount,
                  loading: () => 0,
                  error: (error, stacktrace) => 0,
                )}개',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.53846,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
