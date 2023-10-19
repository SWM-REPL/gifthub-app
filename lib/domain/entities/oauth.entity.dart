// 📦 Package imports:
import 'package:equatable/equatable.dart';

class OAuth with EquatableMixin {
  final String id;
  final String name;
  final String provider;
  final String email;

  OAuth({
    required this.id,
    required this.name,
    required this.provider,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, provider, email];
}
