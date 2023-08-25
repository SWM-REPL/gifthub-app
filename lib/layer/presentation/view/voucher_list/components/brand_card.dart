// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/presentation/notifier/brand_filter.notifier.dart';

class BrandCard extends ConsumerStatefulWidget {
  const BrandCard(
    this.brand, {
    super.key,
  });

  final Brand brand;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BrandCardState();
}

class _BrandCardState extends ConsumerState<BrandCard> {
  @override
  Widget build(BuildContext context) {
    final brandFilter = ref.watch(brandFilterProvider);
    final brandFilterNotifier = ref.read(brandFilterProvider.notifier);

    final isSelected = brandFilter == widget.brand.id;

    void changeBrancFilter() {
      if (brandFilter == widget.brand.id) {
        brandFilterNotifier.state = null;
      } else {
        brandFilterNotifier.state = widget.brand.id;
      }
    }

    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: isSelected
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () => changeBrancFilter(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                fit: BoxFit.cover,
                widget.brand.imageUrl,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.brand.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              '${widget.brand.totalPrice}원',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${widget.brand.totalCount}개',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
