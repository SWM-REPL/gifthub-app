// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/presentation/notifier/vpb.notifier.dart';
import 'package:gifthub/layer/presentation/view/voucher_editor/voucher_editor.widget.dart';
import 'package:gifthub/utility/navigate_route.dart';

class VoucherDetailContent extends ConsumerStatefulWidget {
  const VoucherDetailContent(
    this.vpb, {
    super.key,
  });

  final VPB vpb;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoucherDetailContentState();
}

class _VoucherDetailContentState extends ConsumerState<VoucherDetailContent> {
  void onSavePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('저장 버튼이 클릭되었습니다.'), // TODO
      ),
    );
  }

  void onEditPressed(BuildContext context) {
    navigate(
      context: context,
      widget: VoucherEditor(widget.vpb),
    );
  }

  void onSharePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('공유 버튼이 클릭되었습니다.'), // TODO
      ),
    );
  }

  void onUsePressed(BuildContext context) {
    final vpbNotifier = ref.read(vpbProvider(widget.vpb.voucher.id).notifier);
    vpbNotifier.useVoucher(5000);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: AspectRatio(
            aspectRatio: 2 / 1,
            child: Image.network(
              widget.vpb.product.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Column(
                  children: [
                    Text(
                      widget.vpb.brand.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.vpb.product.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '${widget.vpb.product.price}원',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                      'https://barcode.tec-it.com/barcode.ashx?data=${widget.vpb.voucher.barcode}&translate-esc=on&imagetype=Png',
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => onSavePressed(context),
                            icon: const Icon(
                              Icons.file_download,
                              color: Colors.grey,
                            ),
                            label: const Text(
                              '이미지 저장',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.resolveWith<EdgeInsets>(
                                (states) => const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: () => onEditPressed(context),
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                label: const Text(
                                  '수정하기',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const VerticalDivider(),
                              TextButton.icon(
                                onPressed: () => onSharePressed(context),
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                ),
                                label: const Text(
                                  '공유하기',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        '유의사항',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.vpb.product.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => onUsePressed(context),
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                  (states) => const EdgeInsets.only(
                    top: 16,
                    bottom: 36,
                  ),
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              child: const Text('사용하기'),
            ),
          ),
        ),
      ],
    );
  }
}
