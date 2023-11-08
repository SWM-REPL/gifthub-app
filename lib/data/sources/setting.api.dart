// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/data/dto/remote_config.dto.dart';

class SettingApi {
  final Dio dio;

  SettingApi(this.dio);

  Future<RemoteConfigDto> getRemoteConfig() async {
    final response = await dio.get(GiftHubConstants.remoteConfig);
    return RemoteConfigDto.fromJson(response.data);
  }
}
