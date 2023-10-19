// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/appuser.entity.dart';
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';

class VoucherListState with EquatableMixin {
  final AppUser appUser;
  final List<Voucher> vouchers;
  final List<Brand> brands;
  final int pendingCount;
  final int notificationCount;
  final Map<int, int> brandTotalBalance;

  const VoucherListState({
    required this.appUser,
    required this.vouchers,
    required this.brands,
    required this.pendingCount,
    required this.notificationCount,
    required this.brandTotalBalance,
  });

  @override
  List<Object?> get props => [
        appUser,
        vouchers,
        pendingCount,
        notificationCount,
      ];
}
