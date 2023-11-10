// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/oss_licenses.dart';

class OssLicenseScreen extends StatelessWidget {
  final Package package;

  const OssLicenseScreen(this.package, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Text(package.name, style: Theme.of(context).textTheme.headlineMedium),
      Text(package.version, style: Theme.of(context).textTheme.titleMedium),
      if (package.homepage != null)
        Text(package.homepage!, style: Theme.of(context).textTheme.titleSmall),
      if (package.authors.isNotEmpty) Text(package.authors.join(', ')),
      if (package.license != null) Text(package.license!),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(package.name),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) => items[index],
        separatorBuilder: (context, index) => const SizedBox(
          height: GiftHubConstants.padding,
        ),
      ),
    );
  }
}
