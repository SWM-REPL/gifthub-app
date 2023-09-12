// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/view/sign_in/sign_in.content.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

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
      data: (appUser) {
        handleSuccess(context);
        return const InProgress();
      },
      loading: () => const SignInContent(),
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          return const SignInContent();
        } else if (error is DioException) {
          handleFailure(context);
          return const SignInContent();
        }
        throw error;
      },
    );
  }

  void handleSuccess(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (context.mounted) {
      showSnackBar(context, '로그인에 성공했습니다.');
      navigate(
        VoucherList(),
        context: context,
        predicate: (_) => false,
      );
    }
  }

  void handleFailure(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (context.mounted) {
      showSnackBar(context, '로그인에 실패했습니다.');
    }
  }
}
