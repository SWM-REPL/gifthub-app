// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Product with EquatableMixin {
  const Product({
    required this.id,
    required this.brandId,
    required this.name,
    required this.description,
    required this.isReusable,
    required this.price,
    required this.imageUrl,
  });

  final int id;
  final int brandId;
  final String name;
  final String description;
  final bool isReusable;
  final int price;
  final String imageUrl;

  @override
  List<Object?> get props => [id];
}
