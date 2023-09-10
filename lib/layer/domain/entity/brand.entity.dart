// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Brand with EquatableMixin {
  Brand({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String imageUrl;

  int totalCount = 0;
  int totalPrice = 0;
  int aboutToExpire = 0;

  @override
  List<Object?> get props => [id];
}
