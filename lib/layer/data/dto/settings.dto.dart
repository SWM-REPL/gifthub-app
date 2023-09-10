// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/settings.entity.dart';

class SettingsDto extends Settings {
  SettingsDto({
    super.showNotice = true,
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) {
    return SettingsDto(
      showNotice: json['show_notice'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'show_notice': showNotice,
    };
  }
}
