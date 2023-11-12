// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/presentation/common/event_banner.widget.dart';
import 'package:gifthub/presentation/common/labeled_field.widget.dart';
import 'package:gifthub/presentation/common/labeled_text_field.widget.dart';
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in.screen.dart';
import 'package:gifthub/presentation/user_info/oss_licenses.screen.dart';
import 'package:gifthub/presentation/user_info/user_nickname_editor.view.dart';
import 'package:gifthub/presentation/user_info/user_social_accounts.view.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class UserInfoScreen extends ConsumerWidget {
  final usernameController = TextEditingController();
  final nicknameController = TextEditingController();

  UserInfoScreen({super.key});

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
                  showForwardIcon: false,
                  labelText: '아이디',
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: usernameController.text),
                    );
                    showSnackBar(text: '아이디가 복사되었습니다.');
                  },
                  controller: usernameController,
                  enabled: false,
                ),
                const Divider(),
                LabeledTextField(
                  onTap: () => navigate(UserNicknameEditorView()),
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
              onTap: () => navigate(const UserSocialAccountsView()),
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
          const SizedBox(height: GiftHubConstants.padding),
          const EventBanner(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: appUser.when(
                  data: (user) => () => showConfirm(
                        title: const Text('로그아웃'),
                        content: user.isAnonymous
                            ? const Text(
                                '임시 회원은 로그아웃 시 모든 기프티콘이 삭제되며 복구할 수 없습니다.\n\n비회원 상태로 로그아웃 하기 전 "내 정보 수정" 페이지에서 소셜 계정을 연동할 수 있습니다.\n\n정말로 로그아웃을 하시겠습니까?')
                            : const Text('정말로 로그아웃을 하시겠습니까?'),
                        onConfirmPressed: () async {
                          final settingRepository =
                              await ref.watch(settingRepositoryProvider.future);
                          settingRepository.clear();
                          if (user.isAnonymous) {
                            await ref.watch(deregisterCommandProvider)();
                          } else {
                            await ref.watch(signOutCommandProvider)();
                          }
                          ref.invalidate(authTokenProvider);
                          navigate(const SignInScreen(), clearStack: true);
                        },
                        onCanclePressed: () {},
                      ),
                  loading: () => null,
                  error: (error, stackTrace) => null,
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
                    final settingRepository =
                        await ref.watch(settingRepositoryProvider.future);
                    settingRepository.clear();
                    await ref.watch(deregisterCommandProvider)();
                    ref.invalidate(authTokenProvider);
                    navigate(const SignInScreen(), clearStack: true);
                  },
                  onCanclePressed: () {},
                ),
                child: const Text('회원탈퇴'),
              ),
              const SizedBox(
                height: 20,
                child: VerticalDivider(),
              ),
              TextButton(
                onPressed: () async {
                  final success = await launchUrl(contactUsUri);
                  if (!success) {
                    showSnackBar(text: '문의하기 페이지를 열 수 없습니다.');
                  }
                },
                child: const Text('문의하기'),
              ),
              const SizedBox(
                height: 20,
                child: VerticalDivider(),
              ),
              TextButton(
                onPressed: () {
                  navigate(const OssLicensesScreen());
                },
                child: const Text('오픈소스'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
