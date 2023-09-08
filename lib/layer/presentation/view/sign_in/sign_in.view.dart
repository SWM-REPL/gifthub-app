// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.dio.exception.dart';
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/view/sign_in/sign_in.content.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.widget.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(appUserProvider);
    return appUser.when(
      data: (appUser) => VoucherList(),
      loading: () => const InProgress(),
      error: (error, stackTrace) {
        if (error is UnauthorizedException ||
            error is UnauthorizedDioException) {
          return const SignInContent();
        } else {
          return Center(
            child: Text(error.toString()),
          );
        }
      },
    );
  }
}
