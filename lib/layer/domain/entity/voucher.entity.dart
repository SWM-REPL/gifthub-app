// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Voucher with EquatableMixin {
  Voucher({
    required this.id,
    required this.productId,
    required this.barcode,
    required this.expiredDate,
  });

  final int id;
  final int productId;
  final String barcode;
  final DateTime expiredDate;

  @override
  List<Object?> get props => [id];
}
