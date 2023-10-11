// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in_with_password.view.dart';
import 'package:gifthub/presentation/voucher_list/voucher_list.view.dart';
import 'package:gifthub/utility/navigator.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    appUser.whenData((appUser) {
      if (appUser != null) {
        navigate(const VoucherListView(), clearStack: true);
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildSignInForm(context, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
        icon: const Icon(Icons.close_sharp),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Image.asset('assets/icon.png'),
          ElevatedButton.icon(
            onPressed: () async {
              final authToken =
                  await ref.watch(signInWithKakaoCommandProvider)();
              ref.watch(authTokenProvider.notifier).state = authToken;
            },
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xfffee500)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            icon: Image.asset('assets/kakao.png', height: 22),
            label: Text(
              '카카오로 계속하기',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final authToken =
                  await ref.watch(signInWithNaverCommandProvider)();
              ref.watch(authTokenProvider.notifier).state = authToken;
            },
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff03c659)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            icon: Image.asset('assets/naver.png', height: 16),
            label: Text(
              '네이버로 계속하기',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final authToken =
                  await ref.watch(signInWithGoogleCommandProvider)();
              ref.watch(authTokenProvider.notifier).state = authToken;
            },
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48)),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff4286f4)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              height: 28,
              width: 28,
              child: Center(
                child: Image.asset(
                  'assets/google.png',
                  height: 24,
                ),
              ),
            ),
            label: Text(
              '구글로 계속하기',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
          if (Platform.isIOS) const SizedBox(height: 20),
          if (Platform.isIOS)
            ElevatedButton.icon(
              onPressed: () async {
                final authToken =
                    await ref.watch(signInWithAppleCommandProvider)();
                ref.watch(authTokenProvider.notifier).state = authToken;
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 48)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              icon: Icon(
                Icons.apple,
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
              label: Text(
                'Apple로 계속하기',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          TextButton(
            onPressed: () => navigate(SignInWithPasswordView()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '아이디로 계속하기',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).textTheme.labelMedium!.color,
                  size: Theme.of(context).textTheme.labelMedium!.fontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
