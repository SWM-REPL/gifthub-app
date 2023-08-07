import 'package:dio/dio.dart';

class UnauthorizedException extends DioException {
  UnauthorizedException({required super.requestOptions})
      : super(
          message: 'Unauthorized exception occurred during http request.',
        );
}
