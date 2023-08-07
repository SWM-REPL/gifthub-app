import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthub/exception/unauthorized.exception.dart';

import 'package:gifthub/layer/presentation/provider/presentation.provider.dart';
import 'package:gifthub/layer/presentation/view/sign_in/sign_in.page.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.content.dart';

class VoucherListView extends ConsumerStatefulWidget {
  const VoucherListView({super.key});

  @override
  ConsumerState<VoucherListView> createState() => _VoucherListViewState();
}

class _VoucherListViewState extends ConsumerState<VoucherListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vouchers = ref.watch(vouchersProvider);

    return vouchers.when(
      data: (vouchers) => VoucherListContent(vouchers: vouchers),
      loading: () => const Text('Loading...'),
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          Future.microtask(
            () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (route) => false,
            ),
          );
        }
        return Text(error.toString());
      },
    );
  }
}
