// 📦 Package imports:
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/block.entity.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CreateVoucherByImageCommand {
  final VoucherRepository _voucherRepository;
  final TextRecognizer _textRecognizer;

  CreateVoucherByImageCommand(
      {required VoucherRepository voucherRepository,
      TextRecognizer? textRecognizer})
      : _voucherRepository = voucherRepository,
        _textRecognizer = textRecognizer ??
            TextRecognizer(script: TextRecognitionScript.korean);

  Future<void> call(String imagePath) async {
    final image = InputImage.fromFilePath(imagePath);
    final recognizedText = await _textRecognizer.processImage(image);
    final List<RecognizedTextLine> textlines = [];

    for (final block in recognizedText.blocks) {
      for (final line in block.lines) {
        final textline = RecognizedTextLine.from(line);
        final index = textlines.indexWhere((t) => t.isSameLine(textline));
        if (index == -1) {
          textlines.add(textline);
        } else {
          textlines[index] = textlines[index].merge(textline);
        }
      }
    }

    final texts = textlines.map((t) => t.text).toList();
    await _voucherRepository.createVoucherByTexts(texts);
  }
}
