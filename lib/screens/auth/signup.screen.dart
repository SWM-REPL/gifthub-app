import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/screens/auth/signup.template.dart';
import 'package:gifthub/exceptions/unauthorized.exception.dart';
import 'package:gifthub/screens/auth/tokens.screen.dart';
import 'package:gifthub/utils/screen.dart';

import '../../providers/token.provider.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _nicknameController = TextEditingController();

  void onSignupPressed(TokensNotifier tokenNotifier) {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final passwordCheck = _passwordCheckController.text;
    final nickname = _nicknameController.text;
    tokenNotifier.register(
      username: username,
      password: password,
      passwordCheck: passwordCheck,
      nickname: nickname,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokensNotifierProvider);
    final tokenNotifier = ref.watch(tokensNotifierProvider.notifier);

    final screen = token.when(
      data: (token) {
        openScreen(context, const TokenScreen());
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          return SignupTemplate(
            context: context,
            usernameController: _usernameController,
            passwordController: _passwordController,
            passwordCheckController: _passwordCheckController,
            nicknameController: _nicknameController,
            onSignupPressed: () => onSignupPressed(tokenNotifier),
          );
        }
        return Center(
          child: Text('Error: $error'),
        );
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: screen,
      ),
    );
  }
}
