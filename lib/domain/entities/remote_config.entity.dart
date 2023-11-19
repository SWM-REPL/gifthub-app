// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Event with EquatableMixin {
  final String bannerImageUrl;
  final String clickUrl;

  Event({
    required this.bannerImageUrl,
    required this.clickUrl,
  });

  @override
  List<Object?> get props => [
        bannerImageUrl,
        clickUrl,
      ];
}

class RemoteConfig with EquatableMixin {
  final List<Event> events;
  final String contactUsUrl;
  final int minimalVersion;

  RemoteConfig({
    required this.events,
    required this.contactUsUrl,
    required this.minimalVersion,
  });

  @override
  List<Object?> get props => [
        events,
        contactUsUrl,
        minimalVersion,
      ];
}
