// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/sign_in/sign_in.view.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class ExceptionBoundary extends ConsumerWidget {
  final Widget child;

  const ExceptionBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final next = FlutterError.onError;
    FlutterError.onError = (details) {
      final exception = details.exception;
      if (exception is UnauthorizedException) {
        _handleUnauthorizedException(ref);
      } else if (exception is DioException) {
        _handleDioException(exception);
      } else {
        next?.call(details);
      }
    };
    return child;
  }

  void _handleUnauthorizedException(WidgetRef ref) {
    Future.delayed(Duration.zero, () async {
      ref.invalidate(authTokenProvider);
      ref.watch(tokenRepositoryProvider).deleteAuthToken();
      navigate(const SignInView(), clearStack: true);
    });
  }

  void _handleDioException(DioException exception) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showSnackBar(
        // ignore: avoid_dynamic_calls
        Text(exception.response?.data['error']),
      ),
    );
  }
}
