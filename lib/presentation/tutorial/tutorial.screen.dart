// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/presentation/tutorial/step.widget.dart';
import 'package:gifthub/theme/constant.theme.dart';
import 'package:gifthub/utility/navigator.dart';

class TutorialScreen extends ConsumerWidget {
  static const padding = GiftHubConstants.padding * 3;

  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() async {
      final settingRepository =
          await ref.watch(settingRepositoryProvider.future);
      settingRepository.isTutorialPending = false;
    });
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.125),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(padding),
          topRight: Radius.circular(padding),
        ),
      ),
      height: MediaQuery.of(context).size.height - 100,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: padding,
                left: padding,
                right: padding,
                bottom: padding * 4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              navigateBack();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const TutorialStep(
                        padding,
                        step: 1,
                        text: '기프티콘 사진을 선택한 후 공유하기 메뉴를 열어줍니다',
                      ),
                      const SizedBox(height: padding * 2),
                      TutorialStep(
                        padding,
                        step: 2,
                        text: '여러가지 어플 중 "GiftHub"를 찾아 선택합니다',
                        image: Platform.isIOS
                            ? Image.asset('assets/share-step2-ios.jpg')
                            : Platform.isAndroid
                                ? Image.asset('assets/share-step2-android.jpg')
                                : null,
                      ),
                      if (Platform.isIOS) ...[
                        const SizedBox(height: padding * 2),
                        TutorialStep(
                          padding,
                          step: 3,
                          text: '오른쪽 위 "올리기"를 클릭합니다',
                          image: Image.asset('assets/share-step3-ios.jpg'),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: padding,
            bottom: padding,
            child: ElevatedButton(
              onPressed: () async {
                final images = await ImagePicker().pickMultiImage();
                if (images.isEmpty) {
                  return;
                }

                final paths = images.map((e) => e.path).toList();

                // Wait for 500ms to prevent the dialog from being closed immediately
                await Future.delayed(const Duration(milliseconds: 500));
                // TODO: Use shareXFiles when it's available in Android 11
                // https://github.com/fluttercommunity/plus_plugins/issues/1612
                // ignore: deprecated_member_use
                await Share.shareFiles(paths);
                navigateBack();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize:
                    Size(MediaQuery.of(context).size.width - 2 * padding, 60),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.ios_share),
                  const SizedBox(width: 4),
                  Text(
                    '연습 하러 가기',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
