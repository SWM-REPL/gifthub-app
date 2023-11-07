// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoucherRawImageScreen extends ConsumerWidget {
  final String presignedUrl;

  const VoucherRawImageScreen(this.presignedUrl, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.network(presignedUrl);
  }
}
