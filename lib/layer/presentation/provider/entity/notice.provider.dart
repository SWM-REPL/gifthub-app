// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_notice.provider.dart';

final noticeProvider = FutureProvider.family<Notice, int>((ref, id) async {
  final getNotice = ref.watch(getNoticeProvider);
  return await getNotice(id);
});
