// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/appuser.notifier.dart';
import 'package:gifthub/layer/presentation/view/sign_up/sign_up.content.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
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
      loading: () => const SignUpContent(),
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          return const SignUpContent();
        } else if (error is DioException) {
          handleFailure(context);
          return const SignUpContent();
        }
        throw error;
      },
    );
  }

  void handleSuccess(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (context.mounted) {
      showSnackBar(context, '회원가입에 성공했습니다.');
    }
  }

  void handleFailure(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (context.mounted) {
      showSnackBar(context, '회원가입에 실패했습니다.');
    }
  }
}
