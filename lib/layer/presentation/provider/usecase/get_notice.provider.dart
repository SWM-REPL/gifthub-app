// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_notice.usecase.dart';
import 'package:gifthub/layer/presentation/provider/repository/notice.repository.provider.dart';

final getNoticeProvider = Provider(
  (ref) => GetNotice(
    repository: ref.read(noticeRepositoryProvider),
  ),
);
