// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/providers/config.provider.dart';

class EventBanner extends ConsumerWidget {
  const EventBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteConfig = ref.watch(remoteConfigProvider);
    return CarouselSlider(
      options: CarouselOptions(
        height: VoucherCard.height / 0.8,
        viewportFraction: 0.8,
        autoPlay: true,
      ),
      items: remoteConfig.when(
        data: (config) => config.events
            .map((e) => Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => launchUrl(Uri.parse(e.clickUrl)),
                    child: Card(
                      margin: const EdgeInsets.all(GiftHubConstants.padding),
                      child: SizedBox(
                        height: VoucherCard.height + VoucherCard.padding * 2,
                        width: double.infinity,
                        child: Image.network(e.bannerImageUrl),
                      ),
                    ),
                  ),
                ))
            .toList(),
        loading: () => [const Loading()],
        error: (error, stackTrace) => throw error,
      ),
    );
  }
}
