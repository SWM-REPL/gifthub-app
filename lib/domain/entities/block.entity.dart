// 🎯 Dart imports:
import 'dart:math';

// 📦 Package imports:
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/linear_equation.entity.dart';

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
    final points = [
      cornerPoints[2],
      cornerPoints[3],
      other.cornerPoints[2],
      other.cornerPoints[3],
    ];
    final linearEquation = _linearRegression(points);
    final isLeft = cornerPoints[3].x < other.cornerPoints[3].x;

    final xmin = min(cornerPoints[0].x, other.cornerPoints[0].x);
    final xmax = max(cornerPoints[2].x, other.cornerPoints[2].x);

    return RecognizedTextLine(
      text: isLeft ? '$text ${other.text}' : '${other.text} $text',
      elements: isLeft
          ? [...elements, ...other.elements]
          : [...other.elements, ...elements],
      boundingBox: boundingBox.expandToInclude(other.boundingBox),
      recognizedLanguages: recognizedLanguages,
      cornerPoints: [
        isLeft ? cornerPoints[0] : other.cornerPoints[0],
        isLeft ? other.cornerPoints[1] : cornerPoints[1],
        linearEquation.getIntPoint(xmax),
        linearEquation.getIntPoint(xmin)
      ],
      angle: atan(linearEquation.m) * 180 / pi,
    );
  }

  bool isSameLine(RecognizedTextLine other) {
    final points = [
      cornerPoints[2],
      cornerPoints[3],
      other.cornerPoints[2],
      other.cornerPoints[3]
    ];
    final linearEquation = _linearRegression(points);
    return points.every((p) => linearEquation.getDistance(p) < _threshold);
  }

  LinearEquation _linearRegression(List<Point> points) {
    final n = points.length;
    final sumX = points.map((e) => e.x).reduce((a, b) => a + b);
    final sumY = points.map((e) => e.y).reduce((a, b) => a + b);
    final sumXY = points.map((e) => e.x * e.y).reduce((a, b) => a + b);
    final sumX2 = points.map((e) => e.x * e.x).reduce((a, b) => a + b);

    final m = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    final b = (sumY - m * sumX) / n;

    return LinearEquation(m, b);
  }
}
