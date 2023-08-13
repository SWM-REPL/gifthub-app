// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/provider/usecase/get_voucher_ids.provider.dart';
import 'package:gifthub/layer/presentation/view/sign_in/sign_in.widget.dart';
import 'package:gifthub/layer/presentation/view/voucher_list/voucher_list.content.dart';

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
    final ids = ref.watch(voucherIdsProvider);

    return ids.when(
      data: (ids) => VoucherListContent(
        voucherIds: ids,
      ),
      loading: () => const Text('Loading...'),
      error: (error, stackTrace) {
        if (error is UnauthorizedException) {
          Future.microtask(
            () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ),
            ),
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
