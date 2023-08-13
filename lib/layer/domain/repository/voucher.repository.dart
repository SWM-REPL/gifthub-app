// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

mixin VoucherRepositoryMixin {
  Future<Voucher> getVoucher(int id);
  Future<List<int>> getVoucherIds(int userId);
}
