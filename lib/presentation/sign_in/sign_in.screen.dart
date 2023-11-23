// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/sign_in.exception.dart';
import 'package:gifthub/presentation/loading/loading.screen.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in_with_password.view.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const raccoonCount = 20;

  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool isLoading = false;
  int raccoonCount = SignInScreen.raccoonCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildSignInForm(context),
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

  Widget _buildSignInForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  raccoonCount--;
                  if (raccoonCount == 0) {
                    raccoonCount = SignInScreen.raccoonCount;
                    navigate(SignInWithPasswordView());
                  } else if (raccoonCount < 5) {
                    showSnackBar(text: '$raccoonCount회 남았습니다');
                  }
                });
              },
              child: Image.asset('assets/icon.png'),
            ),
            loginButton(
              signIn: () => ref.watch(signInWithKakaoCommandProvider)(),
              icon: Image.asset('assets/kakao.png', height: 22),
              label: '카카오로 계속하기',
              backgroundColor: const Color(0xfffee500),
            ),
            const SizedBox(height: 20),
            loginButton(
              signIn: () => ref.watch(signInWithNaverCommandProvider)(),
              icon: Image.asset('assets/naver.png', height: 18),
              label: '네이버로 계속하기',
              backgroundColor: const Color(0xff03c659),
              invertColor: true,
            ),
            const SizedBox(height: 20),
            loginButton(
              signIn: () => ref.watch(signInWithGoogleCommandProvider)(),
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
              label: '구글로 계속하기',
              backgroundColor: const Color(0xff4286f4),
              invertColor: true,
            ),
            if (Platform.isIOS) ...[
              const SizedBox(height: 20),
              loginButton(
                signIn: () => ref.watch(signInWithAppleCommandProvider)(),
                icon: Icon(
                  Icons.apple,
                  color: Theme.of(context).textTheme.labelLarge!.color,
                ),
                label: '애플로 계속하기',
                backgroundColor: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }

  ElevatedButton loginButton({
    required final Future<AuthToken> Function() signIn,
    required final Widget icon,
    required final String label,
    required final Color backgroundColor,
    final bool invertColor = false,
  }) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : () => _handleSignIn(signIn),
      icon: icon,
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: isLoading
                  ? Colors.white
                  : invertColor
                      ? Colors.white
                      : Colors.black,
            ),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
        backgroundColor: isLoading
            ? MaterialStateProperty.all(
                Theme.of(context).colorScheme.background)
            : MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.onBackground,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  void _handleSignIn(Future<AuthToken> Function() signIn) async {
    try {
      setState(() => isLoading = true);
      await signIn();
      navigate(const LoadingScreen(), clearStack: true);
    } catch (error) {
      if (error is! SignInException) {
        rethrow;
      }
      showSnackBar(text: error.message ?? '로그인에 실패했습니다.');
    } finally {
      setState(() => isLoading = false);
    }
  }
}
