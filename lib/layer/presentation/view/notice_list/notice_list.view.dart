// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/exception/unauthorized.dio.exception.dart';
import 'package:gifthub/exception/unauthorized.exception.dart';
import 'package:gifthub/layer/presentation/component/in_progress.dart';
import 'package:gifthub/layer/presentation/notifier/notifications.notifier.dart';
import 'package:gifthub/layer/presentation/view/notice_list/notice_list.content.dart';
import 'package:gifthub/layer/presentation/view/sign_in/sign_in.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';

class NoticeListView extends ConsumerStatefulWidget {
  const NoticeListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoticeListViewState();
}

class _NoticeListViewState extends ConsumerState<NoticeListView> {
  @override
  Widget build(BuildContext context) {
    final notices = ref.watch(noticesProvider);
    return notices.when(
      data: (notis) => NoticeListContent(notis),
      loading: () => const InProgress(),
      error: (error, stackTrace) {
        if (error is UnauthorizedException ||
            error is UnauthorizedDioException) {
          navigate(
            const SignIn(),
            context: context,
            predicate: (_) => false,
          );
          return const InProgress();
        }
        throw error;
      },
    );
  }
}
