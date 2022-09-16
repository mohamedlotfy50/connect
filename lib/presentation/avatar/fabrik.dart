import 'dart:math';

import 'package:flutter/animation.dart';

class FABRIK {
  final Map<int, int> parentIndex = {};
  final List<Link> _links = [];

  List<Link> get links => _links;

  void append(
    int id,
    int parentID, {
    required double x1,
    required double y1,
    required double angle,
    required double length,
  }) {
    if (parentIndex.containsKey(parentID)) {
      _links[parentIndex[parentID]!].append();
    } else {
      parentIndex[id] = _links.length;
      links.add(
          Link(parentID, id, x1: x1, y1: y1, angle: angle, length: length));
    }
  }

  void animateJointS(List<Joint> joints) {
    print(parentIndex);
    for (var j in joints) {
      if (parentIndex.containsKey(j.id)) {
        _links[parentIndex[j.id]!].animate(j);
      }
    }
  }
}

class Link {
  late final Joint start, end;
  final double angle, length;
  final List<Link> previous = [];
  final List<Link> next = [];

  Link(
    int id1,
    int id2, {
    required double x1,
    required double y1,
    required this.angle,
    required this.length,
  }) {
    start = Joint(id1, dx: x1, dy: y1);
    end = _calculateEnd(id2);
  }

  Joint _calculateEnd(int id2) {
    double x2 = start.x + length * cos(angle);
    double y2 = start.x + length * sin(angle);
    return Joint(id2, dx: x2, dy: y2);
  }

  void animate(Joint j) {
    if (start.id == j.id) {
      print('animate start');
      start.copyWith(dx: j.x, dy: j.y);
      //TODO:add calculations
      end.copyWith();
      start.printpoint();
    } else if (end.id == j.id) {
      print('animate end');

      end.copyWith(dx: j.x, dy: j.y);
      //TODO:add calculations
      start.copyWith();
      end.printpoint();
    }
  }

  bool containts(int id) {
    return start.id == id || end.id == id;
  }

  void append() {}
}

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
}
