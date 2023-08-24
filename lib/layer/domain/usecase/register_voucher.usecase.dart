// 📦 Package imports:
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/entity/block.entity.dart';
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class RegisterVoucher {
  RegisterVoucher({
    required VoucherRepositoryMixin voucherRepository,
    TextRecognizer? textRecognizer,
  })  : _voucherRepository = voucherRepository,
        _textRecognizer = textRecognizer ??
            TextRecognizer(script: TextRecognitionScript.korean);

  final VoucherRepositoryMixin _voucherRepository;
  final TextRecognizer _textRecognizer;

  Future<int> call({
    String? imagePath,
    String? brandName,
    String? productName,
    DateTime? expiresAt,
    String? barcode,
  }) async {
    assert(
      imagePath == null
          ? [brandName, productName, expiresAt, barcode]
              .every((element) => element != null)
          : [brandName, productName, expiresAt, barcode]
              .every((element) => element == null),
      'imagePath and other values cannot be set at the same time.',
    );

    if (imagePath != null) {
      return _callByImage(imagePath);
    } else {
      return _callByValues(
        brandName: brandName!,
        productName: productName!,
        expiresAt: expiresAt!,
        barcode: barcode!,
      );
    }
  }

  Future<int> _callByImage(String imagePath) async {
    final image = InputImage.fromFilePath(imagePath);
    final result = await _textRecognizer.processImage(image);
    final blocks = _extractBlocks(result);

    final productName = _searchProductName(blocks);
    final branchName = _searchBrancName(blocks);
    final expiresAt = _searchExpiresAt(blocks);
    final giftNumber = _searchGiftNumber(blocks);

    final imageUrl = await _voucherRepository.uploadImage(imagePath);
    final id = await _voucherRepository.registerVoucher(
      barcode: giftNumber ?? '',
      expiresAt: DateTime.parse(expiresAt ?? ''),
      productName: productName ?? '',
      brandName: branchName ?? '',
      imageUrl: imageUrl,
    );
    return id;
  }

  Future<int> _callByValues({
    required String brandName,
    required String productName,
    required DateTime expiresAt,
    required String barcode,
  }) async {
    final id = await _voucherRepository.registerVoucher(
      barcode: barcode,
      expiresAt: expiresAt,
      productName: productName,
      brandName: brandName,
    );
    return id;
  }

  List<Block> _extractBlocks(RecognizedText texts) {
    final blocks = <Block>[];
    for (final block in texts.blocks) {
      for (final line in block.lines) {
        final blockItem = Block(
          line.text,
          xmin: line.boundingBox.left.round(),
          xmax: line.boundingBox.right.round(),
          ymin: line.boundingBox.top.round(),
          ymax: line.boundingBox.bottom.round(),
        );

        bool merged = false;
        for (final block in blocks) {
          if (block.isSameLine(blockItem)) {
            blocks.remove(block);
            blocks.add(Block.merge(block, blockItem));
            merged = true;
            break;
          }
        }
        if (merged == false) {
          blocks.add(blockItem);
        }
      }
    }
    return blocks;
  }

  String? _searchProductName(List<Block> blocks) {
    const pattern = r'상품명|상품권';
    final match = _firstMatch(pattern, blocks);
    if (match == null) {
      return null;
    }

    if (match.contains(':')) {
      return _extractText(match.substring(match.indexOf(':')));
    } else {
      return _extractText(match);
    }
  }

  String? _searchBrancName(List<Block> blocks) {
    const pattern = '교환처|사용처';
    final match = _firstMatch(pattern, blocks);
    if (match == null) {
      return null;
    }

    if (match.contains(':')) {
      return _extractText(match.substring(match.indexOf(':')));
    } else {
      return _extractText(match);
    }
  }

  String? _searchExpiresAt(List<Block> blocks) {
    const pattern = r'\d{4}\.\d{2}\.\d{2}\n|까지|유효기간|사용기간';
    final match = _firstMatch(pattern, blocks);
    if (match == null) {
      return null;
    }

    return _extractPeriod(match);
  }

  String? _searchGiftNumber(List<Block> blocks) {
    const pattern = r'\d{12}|\d{4}\s\d{4}\s\d{4}';
    final match = _firstMatch(pattern, blocks);
    if (match == null) {
      return null;
    }

    return _removeSpaces(_extractText(match));
  }

  String? _firstMatch(String pattern, List<Block> blocks) {
    for (final block in blocks) {
      final text = block.text;
      if (RegExp(pattern).hasMatch(text)) {
        return text;
      }
    }
    return null;
  }

  String? _extractPeriod(String text) {
    if (text.contains(':')) {
      text = text.substring(text.indexOf(':'));
    }

    if (text.contains('까지')) {
      text = text.substring(0, text.indexOf('까지'));
    }

    text = _extractText(text);

    final RegExp pattern = RegExp(r'(\d{4})년\s*(\d{1,2})월\s*(\d{1,2})일');
    final Match? match = pattern.firstMatch(text);
    if (match == null) {
      return text.replaceAll(RegExp(r'\.'), '-');
    }

    final String? year = match.group(1);
    final String? month = match.group(2);
    final String? day = match.group(3);
    return '$year-$month-$day';
  }

  String _extractText(String text) {
    return text.replaceAll(RegExp(r'[^a-zA-Z0-9_가-힣\s+\/&.]+'), '').trim();
  }

  String _removeSpaces(String text) {
    return text.replaceAll(RegExp(r'\s+'), '');
  }
}
