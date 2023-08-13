// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';

class UnauthorizedDioException extends DioException
    with UnauthorizedExceptionMixin {
  UnauthorizedDioException({required super.requestOptions})
      : super(
          message: 'Unauthorized exception occurred during http request.',
        );
}
