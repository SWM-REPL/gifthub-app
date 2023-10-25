// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';

class NotificationSettingView extends ConsumerStatefulWidget {
  const NotificationSettingView({super.key});

  @override
  ConsumerState<NotificationSettingView> createState() =>
      _NotificationSettingViewState();
}

class _NotificationSettingViewState
    extends ConsumerState<NotificationSettingView> {
  bool voucherExpirationNotification = false;

  @override
  Widget build(BuildContext context) {
    initialize(ref);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  void initialize(WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    appUser.whenData((appUser) {
      voucherExpirationNotification = appUser.allowNotifications;
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('알림 설정'),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('기프티콘 만료기한 임박 알림'),
              Switch(
                value: voucherExpirationNotification,
                onChanged: (switchOn) async {
                  if (switchOn) {
                    await ref
                        .watch(allowExpirationNotificationsCommandProvider)();
                  } else {
                    await ref
                        .watch(denyExpirationNotificationsCommandProvider)();
                  }
                  ref.invalidate(appUserProvider);
                  setState(() {
                    voucherExpirationNotification = switchOn;
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
