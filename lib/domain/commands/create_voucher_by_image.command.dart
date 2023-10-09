// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/block.entity.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

class CreateVoucherByImageCommand {
  static const name = 'create_voucher_by_image';

  final VoucherRepository _voucherRepository;
  final TextRecognizer _textRecognizer;
  final FirebaseAnalytics _analytics;

  CreateVoucherByImageCommand({
    required VoucherRepository voucherRepository,
    required FirebaseAnalytics analytics,
    TextRecognizer? textRecognizer,
  })  : _voucherRepository = voucherRepository,
        _analytics = analytics,
        _textRecognizer = textRecognizer ??
            TextRecognizer(script: TextRecognitionScript.korean);

  Future<void> call(String imagePath) async {
    try {
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

      _analytics.logEvent(
        name: CreateVoucherByImageCommand.name,
        parameters: {
          'success': true,
          'texts': texts.join(','),
        },
      );
    } catch (e) {
      _analytics.logEvent(
        name: CreateVoucherByImageCommand.name,
        parameters: {
          'success': false,
          'error': e.toString(),
        },
      );
      rethrow;
    }
  }
}
