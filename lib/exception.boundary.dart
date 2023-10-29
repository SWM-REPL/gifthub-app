// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
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
    final flutterOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      final exception = details.exception;
      if (exception is UnauthorizedException) {
        _handleUnauthorizedException(ref);
      } else if (exception is DioException) {
        _handleDioException(exception);
      } else {
        flutterOnError?.call(details);
      }
    };

    final platformOnError = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      if (exception is UnauthorizedException) {
        _handleUnauthorizedException(ref);
      } else if (exception is DioException) {
        _handleDioException(exception);
      } else {
        platformOnError?.call(exception, stackTrace);
      }
      return true;
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
        text: exception.response?.data['error'],
      ),
    );
  }
}
