// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/exceptions/giftcard_expired.exception.dart';
import 'package:gifthub/domain/exceptions/giftcard_not_found.exception.dart';
import 'package:gifthub/presentation/common/loading.widget.dart';
import 'package:gifthub/presentation/home/home.screen.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class GiftcardScreen extends ConsumerWidget {
  final String id;

  const GiftcardScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration.zero, () async {
      try {
        await ref.watch(acquireGiftcardCommandProvider(id))();
        ref.invalidate(voucherIdsProvider);
        showSnackBar(text: '정상적으로 카드를 획득했습니다');
        navigate(const HomeScreen(), clearStack: true);
      } on GiftcardNotFoundException {
        showConfirm(
          title: const Text('이런 카드는 없는데요?'),
          content: const Text('쏘마 씨앗방 1에 있는 REPL 팀에게 문의해주세요'),
          onConfirmPressed: () => exit(0),
          confirmText: '알겠어요',
        );
      } on GiftcardExpiredException {
        showConfirm(
          title: const Text('이미 만료된 선물입니다'),
          content: const Text('다른 사람이 먼저 받아갔나봐요 🥲'),
          onConfirmPressed: () => exit(0),
          confirmText: '알겠어요',
        );
      }
    });

    return const Scaffold(
      body: Loading(),
    );
  }
}
