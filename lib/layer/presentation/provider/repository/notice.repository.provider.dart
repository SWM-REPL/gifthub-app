// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/repository/notice.repository.dart';
import 'package:gifthub/layer/presentation/provider/source/notice.api.provider.dart';

final noticeRepositoryProvider = Provider<NoticeRepository>(
  (ref) => NoticeRepository(
    api: ref.read(noticeApiProvider),
  ),
);
