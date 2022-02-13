import 'package:flutter/material.dart';

const double borderSize = 10.0;

class ChartPainter extends CustomPainter {
  ChartPainter({
    required this.yAxisValues,
    required this.xAxisValues,
    required this.minValue,
    required this.maxValue,
  });

  final List<double> yAxisValues;
  final List<DateTime> xAxisValues;

  final double minValue;
  final double maxValue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.black);

    final double drawableHeight = size.height - 2 * borderSize;
    final double drawableWidth = size.width - 2 * borderSize;

    final double heightBlockSize = drawableHeight / borderSize;
    final double widthBlockSize = drawableWidth / yAxisValues.length.toDouble();

    final double height = heightBlockSize * 3;
    final double width = drawableWidth;

    final double heightPerUnit = height / (maxValue - minValue);

    final double top = borderSize;
    final double left = borderSize;

    final Offset center = Offset(left + widthBlockSize / 2, top + height / 2);

    _drawOutline(
      canvas: canvas,
      center: center,
      width: widthBlockSize,
      height: height,
    );

    final List<Offset> points = _computePoints(
      canvas: canvas,
      center: center,
      width: widthBlockSize,
      height: height,
      heightPerUnit: heightPerUnit,
    );

    final Path path = _computePath(points);

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    _drawPoints(canvas: canvas, points: points);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) => true;

  _drawOutline({
    required Canvas canvas,
    required Offset center,
    required double width,
    required double height,
  }) {
    for (double _ in yAxisValues) {
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );

      canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
      );

      center += Offset(width, 0);
    }
  }

  List<Offset> _computePoints({
    required Canvas canvas,
    required Offset center,
    required double width,
    required double height,
    required double heightPerUnit,
  }) {
    List<Offset> points = [];

    for (double yValue in yAxisValues) {
      final double value = height - (yValue - minValue) * heightPerUnit;
      final Offset dataPoint =
          Offset(center.dx, center.dy - height / 2 + value);

      points.add(dataPoint);

      center += Offset(width, 0);
    }

    return points;
  }

  void _drawPoints({required Canvas canvas, required List<Offset> points}) {
    for (Offset point in points) {
      canvas.drawCircle(
        point,
        4,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1
          ..style = PaintingStyle.fill,
      );

      canvas.drawCircle(
        point,
        2.5,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1
          ..style = PaintingStyle.fill,
      );
    }
  }

  Path _computePath(List<Offset> points) {
    final Path path = Path();

    for (int i = 0; i < points.length; i++) {
      final Offset point = points[i];

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    return path;
  }
}
