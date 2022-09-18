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
        onPanDown: (details) {
          setState(() {
            offset = details.localPosition;
            widget.fabrik.animateJoint([
              Joint(1,
                  dx: details.localPosition.dx, dy: details.localPosition.dy),
              Joint(2,
                  dx: details.localPosition.dx, dy: details.localPosition.dy),
            ]);
          });
        },
        // onPanUpdate: (details) {
        //   setState(() {
        //     offset = details.localPosition;
        //     widget.fabrik.animateJoint([
        //       Joint(1,
        //           dx: details.localPosition.dx, dy: details.localPosition.dy)
        //     ]);
        //   });
        // },
        child: CustomPaint(
          size: size,
          painter: Shape(widget.fabrik.links, offset),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.fabrik.addEndEffector(2, 3,
                x1: size.width / 2,
                y1: size.height / 2,
                x2: size.width / 2 + 100,
                y2: size.height / 2);
            widget.fabrik.appendTo(3, 4, length: 100, angle: 40 * 180 / m.pi);
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
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    var head = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    var tail = Paint()
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
          Offset(l.head.x, l.head.y), Offset(l.tail.x, l.tail.y), root);
      for (var c in l.previous) {
        canvas.drawLine(
            Offset(c.head.x, c.head.y), Offset(c.tail.x, c.tail.y), root);
      }
      canvas.drawCircle(Offset(l.tail.x, l.tail.y), 1, tail);
      canvas.drawCircle(Offset(l.head.x, l.head.y), 1, head);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
