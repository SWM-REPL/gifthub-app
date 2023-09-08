mixin NullFcmTokenExceptionMixin {
  String get message => 'FCM token is null';
}

class NullFcmTokenException
    with NullFcmTokenExceptionMixin
    implements Exception {}
