// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/domain/entities/remote_config.entity.dart';
import 'package:gifthub/presentation/common/voucher_card.widget.dart';
import 'package:gifthub/presentation/providers/config.provider.dart';

class EventBanner extends ConsumerStatefulWidget {
  const EventBanner({super.key});

  @override
  ConsumerState<EventBanner> createState() => _EventBannerState();
}

class _EventBannerState extends ConsumerState<EventBanner> {
  final timer = Timer.periodic(const Duration(seconds: 1), (timer) {});

  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final config = await ref.watch(remoteConfigProvider.future);
      setState(() {
        for (var e in config.events) {
          events.add(e);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleTapInside(),
      child: Card(
        margin: const EdgeInsets.all(GiftHubConstants.padding),
        child: SizedBox(
          height: VoucherCard.height + VoucherCard.padding * 2,
          width: double.infinity,
          child: Image.asset('assets/event-banner.png'),
        ),
      ),
    );
  }

  void handleTapInside() {
    launchUrl(Uri.parse('https://forms.gle/AWAKLJ6PJHXWs3G99'));
  }
}
