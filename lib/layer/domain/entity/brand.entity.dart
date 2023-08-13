// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Brand with EquatableMixin {
  const Brand({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String imageUrl;

  @override
  List<Object?> get props => [id];
}
