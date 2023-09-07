// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Voucher with EquatableMixin {
  Voucher({
    required this.id,
    required this.productId,
    required this.barcode,
    required this.expiredDate,
    required this.balance,
  });

  final int id;
  final int productId;
  final String barcode;
  final DateTime expiredDate;
  final int balance;

  bool get isUsable =>
      balance > 0 &&
      expiredDate.isAfter(
        DateTime.now().subtract(
          const Duration(days: 1),
        ),
      );
  @override
  List<Object?> get props => [id];
}
