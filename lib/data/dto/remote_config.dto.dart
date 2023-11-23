// 🌎 Project imports:
import 'package:gifthub/domain/entities/remote_config.entity.dart';

class RemoteConfigDto extends RemoteConfig {
  RemoteConfigDto({
    required super.events,
    required super.contactUsUrl,
    required super.minimalVersion,
  });

  factory RemoteConfigDto.fromJson(Map<String, dynamic> json) {
    return RemoteConfigDto(
      events: (List<Map<String, dynamic>>.from(json['events']))
          .map(
            (e) => Event(
              bannerImageUrl: e['image_url'],
              clickUrl: e['href'],
            ),
          )
          .toList(),
      contactUsUrl: json['cs_href'] as String,
      minimalVersion: json['minimal_version'] as int,
    );
  }
}
