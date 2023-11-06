// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/home/home.state.dart';
import 'package:gifthub/theme/constant.theme.dart';

class BrandCard extends ConsumerWidget {
  static const padding = GiftHubConstants.padding;

  final Brand brand;

  const BrandCard(this.brand, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandFilter = ref.watch(brandFilterProvider);
    final isSelected = brandFilter?.id == brand.id;
    return TapRegion(
      onTapInside: (event) {
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
              Text(
                brand.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.53846,
                    ),
              ),
              Text(
                '18,500원',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.55556,
                    ),
              ),
              Text(
                '4개',
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
