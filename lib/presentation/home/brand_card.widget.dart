// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/home/home.state.dart';

class BrandCard extends ConsumerWidget {
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
      child: SizedBox(
        width: 130,
        height: 180,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          margin: EdgeInsets.zero,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  brand.logoUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Text(brand.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
