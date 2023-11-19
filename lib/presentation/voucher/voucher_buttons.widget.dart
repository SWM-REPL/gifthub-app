// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/presentation/editor/editor.screen.dart';
import 'package:gifthub/presentation/providers/brand.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/presentation/voucher/voucher_raw_image.screen.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';

class VoucherButtons extends ConsumerWidget {
  final int voucherId;
  final int productId;
  final int brandId;

  final messageController = TextEditingController();

  VoucherButtons({
    required this.voucherId,
    required this.productId,
    required this.brandId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucher = ref.watch(voucherProvider(voucherId));
    final brand = ref.watch(brandProvider(brandId));
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: voucher.when(
              data: (v) => () => v.imageUrl != null
                  ? _onImageSavePressed(ref)
                  : showConfirm(
                      content: const Text('원본 이미지가 등록되지 않았습니다.'),
                    ),
              loading: () => null,
              error: (error, stackTrace) => throw error,
            ),
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.grey,
            ),
            label: Text(
              '원본 이미지 보기',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(vertical: 16),
              ),
              side: MaterialStateProperty.resolveWith(
                (states) => const BorderSide(
                  color: Colors.grey,
                  width: 0,
                ),
              ),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () => _onEditPressed(),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.grey,
                ),
                label: Text(
                  '수정하기',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              TextButton.icon(
                onPressed: brand.when(
                  data: (b) => () => _onLocationPressed(b),
                  loading: () => null,
                  error: (error, stackTrace) => throw error,
                ),
                icon: const Icon(
                  Icons.map_outlined,
                  color: Colors.grey,
                ),
                label: Text(
                  '위치보기',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              voucher.when(
                data: (v) => v.isShared
                    ? TextButton.icon(
                        onPressed: () => _onRetrievePressed(ref),
                        icon: const Icon(
                          Icons.settings_backup_restore_outlined,
                          color: Colors.grey,
                        ),
                        label: Text(
                          '회수하기',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      )
                    : TextButton.icon(
                        onPressed: () => _onSharePressed(ref),
                        icon: const Icon(Icons.share_outlined,
                            color: Colors.grey),
                        label: Text(
                          '공유하기',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                loading: () => TextButton.icon(
                  onPressed: null,
                  icon: const Icon(
                    Icons.share_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    '공유하기',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
                error: (error, stackTrace) => throw error,
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }

  void _onImageSavePressed(WidgetRef ref) async {
    final presignedUrl = await ref.watch(
      fetchVoucherImageUrlCommandProvider(voucherId),
    )();
    showModal(VoucherRawImageScreen(presignedUrl));
  }

  void _onEditPressed() {
    showModal(
      EditorScreen(
        voucherId: voucherId,
        productId: productId,
        brandId: brandId,
      ),
    );
  }

  void _onLocationPressed(Brand brand) async {
    try {
      await launchUrl(
        Uri.parse('nmap://search?query=${brand.name}'),
      );
    } on PlatformException catch (e) {
      if (e.code == 'ACTIVITY_NOT_FOUND') {
        launchUrl(
          Uri.parse(
            'https://map.naver.com/p/search/${brand.name}',
          ),
        );
      }
    }
  }

  void _onSharePressed(WidgetRef ref) async {
    final isConfirmed = await showConfirm(
      title: const Text('기프티콘 공유하기'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('선물이 완료된 기프티콘은 더이상 사용자의 기프티콘 목록에 표시되지 않습니다.'),
          SizedBox(height: GiftHubConstants.padding),
          Text('정말 선물하시겠습니까?'),
        ],
      ),
      onConfirmPressed: () {},
      onCanclePressed: () {},
      confirmText: '선물하기',
      cancleText: '취소하기',
    );
    if (isConfirmed == null || !isConfirmed) {
      return;
    }

    final isSendClicked = await showConfirm(
      title: const Text('기프티콘 공유하기'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('메시지를 입력해주세요'),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: null,
            controller: messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '받을 사람에게 보낼 메시지',
            ),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
      onConfirmPressed: () {},
      onCanclePressed: () {},
      confirmText: '보내기',
      cancleText: '취소하기',
    );
    if (isSendClicked == null || !isSendClicked) {
      return;
    }

    final message = messageController.text;
    final giftcard = await ref.watch(
      shareVoucherCommandProvider(
        ShareVoucherParameter(
          voucherId: voucherId,
          message: message,
        ),
      ),
    )();
    ref.invalidate(voucherProvider(voucherId));

    Share.share(
      '🎁 선물이 도착했어요 🎁\n\n💌 함께 온 메시지\n$message\n\n${GiftHubConstants.host}/giftcards/${giftcard.id}\n\n🔑 비밀번호: ${giftcard.password}',
      subject: '공유 링크 보내기',
    );
  }

  void _onRetrievePressed(WidgetRef ref) async {
    showConfirm(
      title: const Text('기프티콘 공유 취소하기'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('선물을 취소하면 공유된 링크를 통해 기프티콘을 받을 수 없습니다.'),
          SizedBox(height: GiftHubConstants.padding),
          Text('정말 취소하시겠습니까?'),
        ],
      ),
      onConfirmPressed: () async {
        await ref.watch(retrieveVoucherCommandProvider(voucherId))();
        ref.invalidate(voucherProvider(voucherId));
      },
      confirmText: '네',
      onCanclePressed: () {},
      cancleText: '아니요',
    );
  }
}
