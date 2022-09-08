import 'dart:math';

import 'package:flutter/material.dart';

class WaveScreen extends StatelessWidget {
  const WaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomPaint(
        size: size,
        painter: Shape(),
      ),
    );
  }
}

class Shape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    var path = Path();

    path.moveTo(0, size.height / 2);
    for (double i = 0; i < size.width; i++) {
      path.lineTo(i, size.height / 2 + sin(i * 0.01) * 100);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
