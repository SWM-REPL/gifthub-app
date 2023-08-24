// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/brand.entity.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/vpbs.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/components/brand_card.dart';

class BrandList extends ConsumerStatefulWidget {
  const BrandList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BrandListState();
}

class _BrandListState extends ConsumerState<BrandList> {
  @override
  Widget build(BuildContext context) {
    final brands = ref.watch(brandsProvider);

    return brands.when(
      data: (brands) => _BrandListContent(brands),
      loading: () {
        if (brands.hasValue) {
          return _BrandListContent(brands.value!);
        } else {
          return const InProgress();
        }
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
    );
  }
}

class _BrandListContent extends StatelessWidget {
  const _BrandListContent(this.brands);

  final List<Brand> brands;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => BrandCard(brands[index]),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: brands.length,
      ),
    );
  }
}
