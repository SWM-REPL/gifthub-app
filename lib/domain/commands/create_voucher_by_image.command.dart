// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/commands/command.dart';
import 'package:gifthub/domain/entities/block.entity.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CreateVoucherByImageCommand extends Command {
  final VoucherRepository _voucherRepository;
  final TextRecognizer _textRecognizer;
  final String _imagePath;

  CreateVoucherByImageCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
    required String imagePath,
    TextRecognizer? textRecognizer,
  })  : _voucherRepository = voucherRepository,
        _imagePath = imagePath,
        _textRecognizer = textRecognizer ??
            TextRecognizer(script: TextRecognitionScript.korean),
        super('create_voucher_by_image', analytics);

  Future<void> call() async {
    try {
      final uploadTarget =
          await _voucherRepository.getPresignedUrlToUploadImage();
      await _voucherRepository.uploadImage(_imagePath, uploadTarget);

      final image = InputImage.fromFilePath(_imagePath);
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
      logSuccess({'texts': texts.reduce((value, element) => value + element)});
    } catch (error, stacktrace) {
      logFailure(error, stacktrace);
      rethrow;
    }
  }
}
