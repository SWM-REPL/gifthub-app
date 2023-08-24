// 🎯 Dart imports:
import 'dart:math';

class Block {
  static const threashold = 10;

  Block(
    this.text, {
    required this.xmin,
    required this.xmax,
    required this.ymin,
    required this.ymax,
  });

  Block.merge(Block a, Block b)
      : text = a.xmin < b.xmin ? '${a.text} ${b.text}' : '${b.text} ${a.text}',
        xmin = min(a.xmin, b.xmin),
        xmax = max(a.xmax, b.xmax),
        ymin = min(a.ymin, b.ymin),
        ymax = max(a.ymax, b.ymax);

  final String text;
  final int xmin;
  final int xmax;
  final int ymin;
  final int ymax;

  int get width => xmax - xmin;
  int get height => ymax - ymin;

  bool isSameLine(Block other) {
    return (ymin - other.ymin).abs() <= threashold;
  }
}
