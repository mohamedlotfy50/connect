import 'package:connect/domain/animation/segment.dart';

class Kinematics {
  final Map<String, Segment> _segments = {};

  List<Segment> get getRootSegments => _segments.values.toList();

  void forward() {}
  void inverse() {}

  void addRootSegment(
    String id, {
    required double x,
    required double y,
    required double length,
    required double angle,
  }) {
    _segments[id] = Segment(id, x: x, y: y, length: length, angle: angle);
  }

  void addtoSegment(
    String id,
    String parentID, {
    required double length,
    required double angle,
  }) {
    final Segment? parent = _segments[parentID];
    if (parent != null) {
      _segments[id] = Segment(id,
          x: parent.end.x, y: parent.end.y, length: length, angle: angle)
        ..addPreviousSegment(parentID);
      parent.addNextSegment(id);
    }
  }
}
