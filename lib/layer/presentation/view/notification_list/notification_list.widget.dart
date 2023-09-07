// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 28,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('알림'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w700,
            ),
        titleSpacing: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
