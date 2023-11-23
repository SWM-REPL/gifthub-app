// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/appuser.entity.dart';
import 'package:gifthub/domain/entities/oauth.entity.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
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
    final appUser = ref.watch(appUserProvider);
    return appUser.when(
      data: (appUser) => _buildData(context, ref, appUser),
      loading: () => const Loading(),
      error: (error, stackTrace) {
        showSnackBar(text: error.toString());
        return const SizedBox();
      },
    );
  }

  Widget _buildData(BuildContext context, WidgetRef ref, AppUser appUser) {
    final oauthProviders = [
      OAuth(id: '', name: '', providerCode: 'kakao', email: ''),
      OAuth(id: '', name: '', providerCode: 'naver', email: ''),
      OAuth(id: '', name: '', providerCode: 'google', email: ''),
      if (Platform.isIOS)
        OAuth(id: '', name: '', providerCode: 'apple', email: ''),
    ];
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (appUser.oauth.isNotEmpty)
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
                ...appUser.oauth.map(
                  (oauth) => _buildSocialAccountCard(context, ref, oauth),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...oauthProviders.map(
                (oauth) => IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: oauth.icon,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      await ref.watch(invokeOAuthCommandProvider)(
                        oauth.providerCode,
                      );
                      showSnackBar(text: '새로운 소셜 계정이 연동되었습니다');
                      ref.invalidate(appUserProvider);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialAccountCard(
      BuildContext context, WidgetRef ref, OAuth oauth) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                oauth.email ?? '이메일 정보 제공에 동의하지 않으셨습니다',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: oauth.icon,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    oauth.provider,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.watch(revokeOAuthCommandProvider)(oauth.providerCode);
              ref.invalidate(appUserProvider);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              '해지',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
