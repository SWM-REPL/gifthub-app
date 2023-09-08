// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/notice.entity.dart';
import 'package:gifthub/layer/presentation/component/notice_card.dart';

class NoticeListContent extends StatelessWidget {
  const NoticeListContent(this.notis, {super.key});

  final List<Notice> notis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).padding.left + 20,
        right: MediaQuery.of(context).padding.right + 20,
      ),
      child: ListView.builder(
        itemCount: notis.length,
        itemBuilder: (context, index) {
          final noti = notis[index];
          return NoticeCard(noti);
        },
      ),
    );
  }
}
