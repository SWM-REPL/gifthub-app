// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Brand with EquatableMixin {
  int id;
  String name;
  String logoUrl;

  Brand({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  @override
  List<Object?> get props => [id];
}
