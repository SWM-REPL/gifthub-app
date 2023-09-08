// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/notice.api.dart';

final noticeApiProvider = Provider<NoticeApiMixin>((ref) => NoticeApi());
