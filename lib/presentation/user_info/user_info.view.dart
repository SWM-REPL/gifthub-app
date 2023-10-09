// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/presentation/common/labeled_text_field.widget.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/user_info/user_social_accounts.view.dart';
import 'package:gifthub/utility/navigator.dart';

class UserInfoView extends ConsumerWidget {
  final usernameController = TextEditingController();
  final nicknameController = TextEditingController();
  final socialAccountsController = TextEditingController();

  UserInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    appUser.whenData((appUser) {
      if (appUser == null) {
        throw UnauthorizedException();
      }
      usernameController.text = appUser.username;
      nicknameController.text = appUser.nickname;
      socialAccountsController.text = '카카오톡 | 페이스북';
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('내 정보 수정'),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icon.png', height: 85),
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
                LabeledTextField(
                  labelText: '아이디',
                  controller: usernameController,
                  enabled: false,
                ),
                const Divider(),
                LabeledTextField(
                  labelText: '닉네임',
                  controller: nicknameController,
                  enabled: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: LabeledTextField(
              onTap: (event) => navigate(const UserSocialAccountsView()),
              labelText: '연동된 소셜 계정',
              controller: socialAccountsController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  ref.watch(signOutCommandProvider)();
                  ref.invalidate(voucherIdsProvider);
                },
                child: const Text('로그아웃'),
              ),
              const SizedBox(
                height: 20,
                child: VerticalDivider(),
              ),
              TextButton(
                onPressed: () {
                  ref.watch(deregisterCommandProvider)();
                  ref.invalidate(voucherIdsProvider);
                },
                child: const Text('회원탈퇴'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
