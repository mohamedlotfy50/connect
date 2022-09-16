import 'dart:async';
import 'dart:math' as m;
import 'package:connect/domain/animation/kinematics.dart';
import 'package:connect/domain/animation/segment.dart';
import 'package:connect/presentation/avatar/fabrik.dart';
import 'package:flutter/material.dart';

class AvatarScreen extends StatefulWidget {
  final FABRIK fabrik = FABRIK();

  AvatarScreen({Key? key}) : super(key: key);

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  Offset? offset;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onPanDown: ((details) {
          setState(() {
            offset = details.localPosition;
            widget.fabrik.animateJointS([
              Joint(1,
                  dx: details.localPosition.dx, dy: details.localPosition.dy)
            ]);
          });
        }),
        child: CustomPaint(
          size: size,
          painter: Shape(widget.fabrik.links, offset),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.fabrik.append(1, 0,
                x1: 0, y1: size.height / 2, angle: 0, length: 100);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Shape extends CustomPainter {
  final Offset? offset;
  final List<Link> links;

  Shape(this.links, this.offset);
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
    if (offset != null) {
      canvas.drawCircle(offset!, 2, child);
    }
    for (var l in links) {
      canvas.drawLine(
          Offset(l.start.x, l.start.y), Offset(l.end.x, l.end.y), root);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
