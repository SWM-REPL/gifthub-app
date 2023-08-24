// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/sign_in/sign_in.widget.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.content.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherListView extends ConsumerStatefulWidget {
  const VoucherListView({
    super.key,
  });

  @override
  ConsumerState<VoucherListView> createState() => _VoucherListViewState();
}

class _VoucherListViewState extends ConsumerState<VoucherListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vpbs = ref.watch(vpbsProvider);

    return vpbs.when(
      data: (vpbs) => VoucherListContent(vpbs),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          navigate(
            context: context,
            widget: const SignIn(),
            predicate: (_) => false,
          );
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        throw error;
      },
    );
  }
}
