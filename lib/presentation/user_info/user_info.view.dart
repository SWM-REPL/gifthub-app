// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/common/labeled_field.widget.dart';
import 'package:gifthub/presentation/common/labeled_text_field.widget.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in.view.dart';
import 'package:gifthub/presentation/user_info/user_nickname_editor.view.dart';
import 'package:gifthub/presentation/user_info/user_social_accounts.view.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';

class UserInfoView extends ConsumerWidget {
  final usernameController = TextEditingController();
  final nicknameController = TextEditingController();

  UserInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    appUser.whenData((appUser) {
      usernameController.text = appUser.username;
      nicknameController.text = appUser.nickname;
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
    final appUser = ref.watch(appUserProvider);
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
                  onTap: (event) => navigate(UserNicknameEditorView()),
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
            child: LabeledField(
              labelText: '연동된 소셜 계정',
              onTap: (event) => navigate(const UserSocialAccountsView()),
              child: appUser.when(
                data: (appUser) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 50),
                    ...appUser.oauth.map((e) => e.icon),
                  ],
                ),
                loading: () => const SizedBox.shrink(),
                error: (error, stackTrace) => const SizedBox.shrink(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => showConfirm(
                  title: const Text('로그아웃'),
                  content: const Text('정말로 로그아웃을 하시겠습니까?'),
                  onConfirmPressed: () async {
                    await ref.watch(signOutCommandProvider)();
                    navigate(const SignInView(), clearStack: true);
                  },
                ),
                child: const Text('로그아웃'),
              ),
              const SizedBox(
                height: 20,
                child: VerticalDivider(),
              ),
              TextButton(
                onPressed: () => showConfirm(
                  title: const Text('회원 탈퇴'),
                  content: const Text('정말로 회원 탈퇴를 하시겠습니까?'),
                  onConfirmPressed: () async {
                    await ref.watch(deregisterCommandProvider)();
                    navigate(const SignInView(), clearStack: true);
                  },
                ),
                child: const Text('회원탈퇴'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
