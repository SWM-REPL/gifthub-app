// 📦 Package imports:
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// 🌎 Project imports:
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

  Future<int> call(String imagePath) async {
    final image = InputImage.fromFilePath(imagePath);
    final result = await _textRecognizer.processImage(image);

    final imageUrl = await _voucherRepository.uploadImage(imagePath);
    final id = await _voucherRepository.registerVoucher(
      barcode: _getBarcode(result),
      expiresAt: _getExpireDate(result),
      productName: _getProductName(result),
      brandName: _getBrandName(result),
      imageUrl: imageUrl,
    );
    return id;
  }

  String _getBarcode(RecognizedText text) {
    for (final block in text.blocks) {
      block.text;
    }
    return '382615379271';
  }

  DateTime _getExpireDate(RecognizedText text) {
    for (final block in text.blocks) {
      block.text;
    }
    return DateTime.now();
  }

  String _getProductName(RecognizedText text) {
    for (final block in text.blocks) {
      block.text;
    }
    return 'CU 모바일상품권 5천원권';
  }

  String _getBrandName(RecognizedText text) {
    for (final block in text.blocks) {
      block.text;
    }
    return 'CU';
  }
}
