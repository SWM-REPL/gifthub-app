// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/editor/editor.screen.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/voucher.provider.dart';
import 'package:gifthub/theme/constant.theme.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_confirm.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

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
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _onImageSavePressed(ref),
            icon: const Icon(
              Icons.file_download_outlined,
              color: Colors.grey,
            ),
            label: Text(
              '이미지 저장',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(vertical: 16),
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
                onPressed: () => _onSharePressed(ref),
                icon: Icon(
                  voucher.when(
                    data: (v) => v.isShared
                        ? Icons.cancel_rounded
                        : Icons.share_outlined,
                    loading: () => Icons.share_outlined,
                    error: (error, stackTrace) => throw error,
                  ),
                  color: Colors.grey,
                ),
                label: Text(
                  voucher.when(
                    data: (v) => v.isShared ? '공유 취소하기' : '공유하기',
                    loading: () => '',
                    error: (error, stackTrace) => throw error,
                  ),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
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

  void _onImageSavePressed(WidgetRef ref) {
    showSnackBar(text: '준비 중입니다.');
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

  void _onSharePressed(WidgetRef ref) async {
    showConfirm(
      title: const Text('기프티콘 공유하기'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('선물이 완료된 기프티콘은 더이상 사용자의 기프티콘 목록에 표시되지 않습니다.'),
          Text(''),
          Text('정말 선물하시겠습니까?'),
        ],
      ),
      onConfirmPressed: () => showConfirm(
        title: const Text('기프티콘 공유하기'),
        content: _buildMessageField(),
        onConfirmPressed: () async {
          final message = messageController.text;
          final giftcard = await ref.watch(
            shareVoucherCommandProvider(
              ShareVoucherParameter(
                voucherId: voucherId,
                message: message,
              ),
            ),
          )();
          Share.share(
            '🎁 선물이 도착했어요 🎁\n\n💌 함께 온 메시지\n$message\n\n${GiftHubConstants.host}/giftcards/${giftcard.id}\n\n🔑 비밀번호: ${giftcard.password}',
            subject: '공유 링크 보내기',
          );
        },
      ),
      confirmText: '선물하기',
    );
  }

  Widget _buildMessageField() {
    return Column(
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
    );
  }
}
