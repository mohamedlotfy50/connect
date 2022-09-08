import 'dart:async';
import 'dart:math' as m;
import 'package:connect/domain/animation/kinematics.dart';
import 'package:connect/domain/animation/segment.dart';
import 'package:flutter/material.dart';

class AvatarScreen extends StatefulWidget {
  final Kinematics k = Kinematics();

  AvatarScreen({Key? key}) : super(key: key);

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  testCreation() {
    for (int i = 0; i < 5; i++) {
      widget.k.addRootSegment('$i', x: 400, y: 400, length: 100, angle: i * 10);
    }
    for (int i = 0; i < 5; i++) {
      widget.k.addtoSegment('$i$i', '$i', length: 100, angle: i * 10);
    }
    for (int i = 0; i < 5; i++) {
      widget.k.addtoSegment('$i$i$i', '$i$i', length: 100, angle: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    testCreation();
    return Scaffold(
      body: CustomPaint(
        size: size,
        painter: Shape(widget.k),
      ),
    );
  }
}

class Shape extends CustomPainter {
  final Kinematics kinematics;

  Shape(this.kinematics);
  @override
  void paint(Canvas canvas, Size size) {
    var root = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    var child = Paint()
      ..color = Colors.teal
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    for (var s in kinematics.getRootSegments) {
      var path = Path();
      path.moveTo(s.start.x, s.start.y);
      path.lineTo(s.end.x, s.end.y);
      canvas.drawPath(path, s.id.length == 1 ? root : child);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
