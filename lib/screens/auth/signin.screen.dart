import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/exceptions/unauthorized.exception.dart';
import 'package:gifthub/screens/auth/tokens.screen.dart';
import 'package:gifthub/utils/screen.dart';
import 'package:gifthub/screens/auth/signin.template.dart';
import 'package:gifthub/providers/token.provider.dart';

class SigninScreen extends ConsumerWidget {
  SigninScreen({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void onSigninPressed(TokensNotifier tokenNotifier) {
    final username = _usernameController.text;
    final password = _passwordController.text;
    tokenNotifier.authenticate(
      username: username,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokensNotifierProvider);
    final tokenNotifier = ref.watch(tokensNotifierProvider.notifier);

    final screen = token.when(
      data: (tokens) {
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
      error: (error, stack) {
        if (error is UnauthorizedException) {
          return SigninTemplate(
            usernameController: _usernameController,
            passwordController: _passwordController,
            onSigninPressed: () => onSigninPressed(tokenNotifier),
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
