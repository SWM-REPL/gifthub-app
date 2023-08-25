// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/vpbs.notifier.dart';
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
      loading: () {
        if (vpbs.hasValue) {
          return VoucherListContent(vpbs.value!);
        } else {
          return const InProgress();
        }
      },
      error: (error, stackTrace) {
        if ((error is UnauthorizedException) ||
            // Remove this 401 error
            (error is DioException && error.response!.statusCode == 401)) {
          navigate(
            context: context,
            widget: const SignIn(),
            predicate: (_) => false,
          );
          return const InProgress();
        }
        throw error;
      },
    );
  }
}
