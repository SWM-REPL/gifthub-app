import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/presentation/notifier/vouchers.notifier.dart';

final vouchersProvider = AsyncNotifierProvider<VouchersNotifier, List<Voucher>>(
  () => VouchersNotifier(),
);
