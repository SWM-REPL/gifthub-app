// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/home/brand_card.widget.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/theme/constant.theme.dart';

class HomeBrands extends ConsumerWidget {
  static const padding = GiftHubConstants.padding;

  const HomeBrands({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandsProvider);
    return brands.when(
      data: (brands) => SizedBox(
        height: 164,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: padding),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return BrandCard(brands[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: padding);
          },
        ),
      ),
      loading: () => const Loading(),
      error: (error, stackTrace) {
        throw error;
      },
    );
  }
}
