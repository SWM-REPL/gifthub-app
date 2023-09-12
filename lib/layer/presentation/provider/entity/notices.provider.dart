// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notices.entity.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_notices.provider.dart';

final noticesProvider = FutureProvider<Notices>((ref) async {
  final getNotices = ref.watch(getNoticesProvider);
  return await getNotices();
});
