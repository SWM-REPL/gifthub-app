// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_notices.provider.dart';

final noticesProvider = FutureProvider<List<Notice>>((ref) async {
  final getNotice = ref.watch(getNoticesProvider);
  return await getNotice();
});
