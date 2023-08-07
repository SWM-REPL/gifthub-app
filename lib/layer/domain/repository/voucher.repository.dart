import 'package:gifthub/layer/domain/entity/voucher.entity.dart';

mixin VoucherRepositoryMixin {
  Future<Voucher> getVoucher({required int id});
  Future<List<int>> getVoucherIds();
}
