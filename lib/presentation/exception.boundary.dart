// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/presentation/sign_in/sign_in.view.dart';
import 'package:gifthub/utility/navigator.dart';

class ExceptionBoundary extends StatelessWidget {
  final Widget child;

  const ExceptionBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final next = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exception is UnauthorizedException) {
        navigate(const SignInView(), clearStack: true);
      } else {
        next?.call(details);
      }
    };
    return child;
  }
}
