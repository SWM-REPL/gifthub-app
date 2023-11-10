// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/oss_licenses.dart';
import 'package:gifthub/presentation/user_info/oss_license.screen.dart';
import 'package:gifthub/theme/color.theme.dart';
import 'package:gifthub/utility/navigator.dart';

class OssLicensesScreen extends StatelessWidget {
  const OssLicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오픈소스 라이선스 정보'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(GiftHubConstants.padding),
        itemCount: ossLicenses.length,
        itemBuilder: (context, index) => ListTile(
          tileColor: GiftHubColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GiftHubConstants.padding),
          ),
          contentPadding: const EdgeInsets.all(GiftHubConstants.padding),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: Text(ossLicenses[index].name),
          subtitle: Text(ossLicenses[index].description),
          onTap: () => navigate(OssLicenseScreen(ossLicenses[index])),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: GiftHubConstants.padding,
        ),
      ),
    );
  }
}
