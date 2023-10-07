// 🎯 Dart imports:
import 'dart:math';

class LinearEquation {
  final double m;
  final double b;

  LinearEquation(this.m, this.b);

  Point<int> getIntPoint(int x) => Point(x, (m * x + b).toInt());
  double getDistance(Point p) => (m * p.x - p.y + b) / sqrt(m * m + 1);
}
