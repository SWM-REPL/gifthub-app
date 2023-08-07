import 'package:equatable/equatable.dart';

class Voucher with EquatableMixin {
  Voucher({
    required this.id,
    required this.productId,
    required this.barcode,
    required this.expiredDate,
    this.imageUrl,
    this.name,
    this.price,
  });

  final int id;
  final int productId;
  final String barcode;
  final DateTime expiredDate;
  String? imageUrl;
  String? name;
  int? price;

  @override
  List<Object?> get props => [id, imageUrl, name, price];
}
