mixin UnauthorizedExceptionMixin {
  String get message => 'Unauthorized exception occurred during http request.';
}

class UnauthorizedException
    with UnauthorizedExceptionMixin
    implements Exception {}
