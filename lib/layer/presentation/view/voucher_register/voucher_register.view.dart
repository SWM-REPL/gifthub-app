// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/view/voucher_register/voucher_register.content.dart';

class VoucherRegisterView extends ConsumerStatefulWidget {
  const VoucherRegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherRegisterViewState();
}

class _VoucherRegisterViewState extends ConsumerState<VoucherRegisterView> {
  @override
  Widget build(BuildContext context) {
    return const VoucherRegisterContent();
  }
}
