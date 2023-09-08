// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/update_fcm_token.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/notice.repository.provider.dart';

final updateFcmTokenProvider = Provider<UpdateFcmToken>((ref) {
  return UpdateFcmToken(ref.read(noticeRepositoryProvider));
});
