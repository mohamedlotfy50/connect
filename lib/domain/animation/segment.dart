import 'dart:math' as math;
import 'package:connect/domain/animation/kinematics.dart';
import 'package:vector_math/vector_math.dart';

class Segment {
  final String id;
  late Vector2 start, end;
  late double length, angle;
  final List<String> _p = [];
  final List<String> _n = [];

  List<String> get previous => _p;
  List<String> get next => _n;

  Segment(
    this.id, {
    required x,
    required y,
    required this.length,
    required this.angle,
  }) {
    start = Vector2(x, y);
    end = Vector2(getEndX(), getEndy());
  }

  double getEndX() {
    return start.x + math.cos(angle) * length;
  }

  double getEndy() {
    return start.y + math.sin(angle) * length;
  }

  void update() {
    end = Vector2(getEndX(), getEndy());
  }

  void addPreviousSegment(String id) {
    _p.add(id);
  }

  void addNextSegment(String id) {
    _n.add(id);
  }
}
