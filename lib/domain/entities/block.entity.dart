// 🎯 Dart imports:
import 'dart:math';

// 📦 Package imports:
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizedTextLine extends TextLine {
  static const _threshold = 10;

  RecognizedTextLine({
    required super.text,
    required super.elements,
    required super.boundingBox,
    required super.recognizedLanguages,
    required super.cornerPoints,
    required super.angle,
  }) : super(
          confidence: null,
        );

  factory RecognizedTextLine.from(TextLine textLine) {
    return RecognizedTextLine(
      text: textLine.text,
      elements: textLine.elements,
      boundingBox: textLine.boundingBox,
      recognizedLanguages: textLine.recognizedLanguages,
      cornerPoints: textLine.cornerPoints,
      angle: textLine.angle,
    );
  }

  RecognizedTextLine merge(RecognizedTextLine other) {
    final a = (cornerPoints[3].x < other.cornerPoints[3].x) ? this : other;
    final b = (a == this) ? other : this;
    return RecognizedTextLine(
      text: '${a.text} ${b.text}',
      elements: [
        ...a.elements,
        ...b.elements,
      ],
      boundingBox: a.boundingBox.expandToInclude(b.boundingBox),
      recognizedLanguages: a.recognizedLanguages,
      cornerPoints: [
        a.cornerPoints[0],
        a.cornerPoints[1],
        b.cornerPoints[2],
        b.cornerPoints[3],
      ],
      angle: (b.cornerPoints[2].y - a.cornerPoints[3].y) /
          (b.cornerPoints[2].x - a.cornerPoints[3].x),
    );
  }

  bool isSameLine(RecognizedTextLine other) {
    final ymin = cornerPoints.map((p) => p.y).reduce(min);
    final ymax = cornerPoints.map((p) => p.y).reduce(max);
    return (ymax - ymin) < _threshold;
  }
}
