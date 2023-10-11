// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/utility/format_string.dart';

class Product with EquatableMixin {
  int id;
  int brandId;
  String name;
  String? description;
  bool isReusable;
  int? price;
  String imageUrl;

  Product({
    required this.id,
    required this.brandId,
    required this.name,
    required this.description,
    required this.isReusable,
    required this.price,
    required this.imageUrl,
  });

  String get priceFormatted => currencyFormat(price!);

  @override
  List<Object?> get props => [id];
}
