import 'dart:math';

import 'package:flutter/animation.dart';

class FABRIK {
  final Map<int, int> parentIndex = {};
  final Map<int, int> childIndex = {};
  final List<Link> _links = [];

  List<Link> get links => _links;

  void appendTo(
    int headID,
    int tailID, {
    double? x1,
    double? y1,
    double? angle,
    double? length,
  }) {
    if (!childIndex.containsKey(headID)) {
      throw Exception('invalid');
    }
    int location = childIndex[headID]!;
    childIndex[tailID] = location;
    if (angle != null && length != null) {
      _links[location]
          .appendByLength(headID, tailID, angle: angle, length: length);
    } else if (x1 != null && y1 != null) {
      _links[location].appendByPoints(headID, tailID, x1: x1, y1: y1);
    } else {
      throw Exception('invalid');
    }
  }

  void addEndEffector(
    int headID,
    int tailID, {
    required double x1,
    required double y1,
    double? x2,
    double? y2,
    double? angle,
    double? length,
  }) {
    parentIndex[headID] = _links.length;
    childIndex[tailID] = _links.length;
    Link l;
    if (length != null && angle != null) {
      l = Link.fromLength(tailID, headID,
          x1: x1, y1: y1, angle: angle, length: length);
    } else if (x2 != null && y2 != null) {
      l = Link.fromPoints(tailID, headID, x1: x1, y1: y1, x2: x2, y2: y2);
    } else {
      throw Exception('inavlid');
    }
    _links.add(l);
  }

  void animateJoint(List<Joint> joints) {
    for (var j in joints) {
      if (parentIndex.containsKey(j.id)) {
        _links[parentIndex[j.id]!].animate(j);
      }
    }
  }
}

//*Links
class Link {
  final Joint head, tail;
  final double length;
  double angle;
  final List<Link> previous = [];
  final List<Link> next = [];

  Link._(this.head, this.tail, this.length, this.angle);

  factory Link.fromLength(
    int tailID,
    int headID, {
    required double x1,
    required double y1,
    required double angle,
    required double length,
  }) {
    var t = Joint(tailID, dx: x1, dy: y1);
    double x2 = t.x + length * cos(angle);
    double y2 = t.y + length * sin(angle);
    var h = Joint(headID, dx: x2, dy: y2);

    return Link._(h, t, length, angle);
  }

  factory Link.fromPoints(
    int tailID,
    int headID, {
    required double x1,
    required double y1,
    required double x2,
    required double y2,
  }) {
    var t = Joint(tailID, dx: x1, dy: y1);
    var h = Joint(headID, dx: x2, dy: y2);
    var d = Joint.distance(t, h);
    var a = asin(((h._y - t.y) / d));

    return Link._(h, t, d, a);
  }

  void _calculateTail() {
    var direction = Joint.sub(tail, head);
    var normal = direction / Joint.distance(head, tail);
    var sum = normal * length;
    var newPoint = Joint.add(head, sum);
    tail.copyWith(dx: newPoint.x, dy: newPoint.y);
  }

  void animate(Joint target) {
    if (head.id == target.id) {
      head.copyWith(dx: target._x, dy: target._y);
      _calculateTail();
      for (var c in previous) {
        c.animate(tail);
      }
    } else if (tail.id == target.id) {}
  }

  bool containts(int id) {
    return head.id == id || tail.id == id;
  }

  void appendByPoints(
    int headID,
    int tailID, {
    required double x1,
    required double y1,
  }) {
    if (headID == tail.id) {
      previous.add(Link.fromPoints(tailID, headID,
          x1: x1, y1: y1, x2: tail.x, y2: tail.y));
    }
  }

  void appendByLength(
    int headID,
    int tailID, {
    required double angle,
    required double length,
  }) {
    if (headID == tail.id) {
      previous.add(Link.fromLength(tailID, headID,
          x1: tail.x, y1: tail.y, angle: angle, length: length));
    }
  }
}

//* joint
class Joint {
  final int id;
  late double _x, _y;

  double get x => _x;
  double get y => _y;

  Joint(
    this.id, {
    required double dx,
    required double dy,
  }) {
    _x = dx;
    _y = dy;
  }

  void copyWith({
    double? dx,
    double? dy,
  }) {
    _x = dx ?? _x;
    _y = dy ?? _y;
  }

  void printpoint() {
    print('x = $_x, y = $_y');
  }

  double heading() {
    return atan2(_y, x);
  }

  static Joint sub(Joint j1, Joint j2, {int? id}) {
    return Joint(id ?? j1.id, dx: j1._x - j2._x, dy: j1._y - j2._y);
  }

  static Joint add(Joint j1, Joint j2, {int? id}) {
    return Joint(id ?? j1.id, dx: j1._x + j2._x, dy: j1._y + j2._y);
  }

  static double distance(Joint j1, Joint j2) {
    return sqrt((pow(j1._x - j2._x, 2) + pow(j1._y - j2._y, 2)));
  }

  Joint operator *(num n) {
    return Joint(id, dx: _x * n, dy: _y * n);
  }

  Joint operator /(num n) {
    return Joint(id, dx: _x / n, dy: _y / n);
  }
}
