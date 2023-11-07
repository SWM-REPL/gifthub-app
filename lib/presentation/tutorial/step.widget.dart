// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/theme/constant.theme.dart';

class TutorialStep extends StatelessWidget {
  final double padding;

  final int step;
  final String text;
  final Image? image;

  const TutorialStep(
    this.padding, {
    required this.step,
    required this.text,
    this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  step.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: padding),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        if (image != null) ...[
          SizedBox(height: padding / 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(GiftHubConstants.padding),
            child: image!,
          ),
        ],
      ],
    );
  }
}
