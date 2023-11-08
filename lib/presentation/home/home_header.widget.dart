// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_break_text/word_break_text.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/presentation/common/event_banner.widget.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/user_info/user_info.screen.dart';
import 'package:gifthub/utility/navigator.dart';

class HomeHeader extends ConsumerWidget {
  static const padding = GiftHubConstants.padding;

  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    final nickname = appUser.when(
      data: (user) => user.nickname,
      loading: () => '',
      error: (error, stacktrace) => throw error,
    );
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(padding * 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(padding * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('안녕하세요.'),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(4),
                            ),
                            onPressed: () => navigate(UserInfoScreen()),
                            child: Row(
                              children: [
                                Text(
                                  '$nickname님',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withAlpha(128),
                                        decorationThickness: 8,
                                      ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      WordBreakText(
                        '만료 예정 기프티콘을 확인하세요!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Image.asset('assets/icon-circle.png'),
                ),
              ],
            ),
          ),
        ),
        const EventBanner(),
      ],
    );
  }
}
