import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthub/exceptions/unauthorized.exception.dart';
import 'package:gifthub/providers/token.provider.dart';

import 'package:gifthub/screens/auth/signin.screen.dart';
import 'package:gifthub/utils/screen.dart';

class TokenScreen extends ConsumerWidget {
  const TokenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokensNotifierProvider);
    final tokenNotifier = ref.watch(tokensNotifierProvider.notifier);

    final screen = token.when(
      data: (tokens) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Access Token',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(tokens.accessToken),
              Text(
                'Refresh Token',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(tokens.refreshToken),
              ElevatedButton(
                onPressed: () {
                  tokenNotifier.signout();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stack) {
        if (error is UnauthorizedException) {
          openScreen(context, SigninScreen());
        }
        return const Center(
          child: CircularProgressIndicator(),
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
