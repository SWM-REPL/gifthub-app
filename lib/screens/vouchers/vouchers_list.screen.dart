import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/exceptions/unauthorized.exception.dart';
import 'package:gifthub/providers/vouchers.provider.dart';
import 'package:gifthub/screens/auth/signin.screen.dart';
import 'package:gifthub/utils/screen.dart';

class VoucherListScreen extends ConsumerWidget {
  const VoucherListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vouchers = ref.watch(vouchersNotifierProvider);

    final screen = vouchers.when(
      data: (data) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Vouchers: $data'),
        ],
      ),
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          openScreen(context, SigninScreen());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      loading: () => const CircularProgressIndicator(),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: screen,
      ),
    );
  }
}
