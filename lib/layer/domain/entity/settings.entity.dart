// 📦 Package imports:
import 'package:equatable/equatable.dart';

class Settings with EquatableMixin {
  Settings({
    this.showNotice = false,
  });

  final bool showNotice;

  Settings copyWith({
    bool? showNotice,
  }) {
    return Settings(
      showNotice: showNotice ?? this.showNotice,
    );
  }

  @override
  List<Object?> get props => [showNotice];
}
