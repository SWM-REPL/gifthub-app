// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notices.entity.dart';

class NoticesDto extends Notices {
  NoticesDto(super.notices);

  factory NoticesDto.fromJson(List<Map<String, dynamic>> json) => NoticesDto(
        List<NoticesEntity>.from(
          (json).map((x) => NoticesEntity.fromJson(x)),
        ),
      );
}
