// 📦 Package imports:
import 'package:dio/dio.dart';

class UnauthorizedException extends DioException {
  UnauthorizedException({
    RequestOptions? requestOptions,
    super.response,
    super.message,
    super.error,
    super.type,
    super.stackTrace,
  }) : super(requestOptions: requestOptions ?? RequestOptions(path: ''));

  UnauthorizedException.from(DioException exception)
      : super(
          requestOptions: exception.requestOptions,
          response: exception.response,
          message: exception.message,
          error: exception.error,
          type: exception.type,
          stackTrace: exception.stackTrace,
        );
}
