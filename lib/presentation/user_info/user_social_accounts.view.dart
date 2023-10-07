// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/utility/show_snack_bar.dart';

class UserSocialAccountsView extends ConsumerWidget {
  const UserSocialAccountsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('연동된 소셜 계정'),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child:
                Text('소셜 계정', style: Theme.of(context).textTheme.titleMedium),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: [
                _buildSocialAccountCard(context, ref),
                const Divider(),
                _buildSocialAccountCard(context, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialAccountCard(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'seheon99@kakao.com',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Image.asset('assets/kakao.png', height: 12),
                  Text(
                    '카카오톡',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => showSnackBar(const Text('해지 클릭')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              '해지',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
