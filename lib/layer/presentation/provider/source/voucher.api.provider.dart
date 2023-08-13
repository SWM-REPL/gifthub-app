// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/data/source/network/voucher.api.dart';

final voucherApiProvider = Provider<VoucherApiMixin>((ref) => VoucherApi());
