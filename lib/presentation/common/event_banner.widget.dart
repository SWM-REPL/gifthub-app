// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher.dart';

class EventBanner extends StatelessWidget {
  const EventBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleTapInside(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.asset('assets/event-banner.png'),
      ),
    );
  }

  void handleTapInside() {
    launchUrl(Uri.parse('https://forms.gle/AWAKLJ6PJHXWs3G99'));
  }
}
