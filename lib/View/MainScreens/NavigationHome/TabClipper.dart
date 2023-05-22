import 'dart:math' as math;

import 'package:flutter/material.dart';

class TabClipper extends CustomClipper<Path> {
  final double radius;

  TabClipper({this.radius = 30.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180), degreeToRadians(90), false);
    path.arcTo(Rect.fromLTWH(((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(70), false);
    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v), degreeToRadians(160),
        degreeToRadians(-140), false);
    path.arcTo(Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0, radius, radius),
        degreeToRadians(200), degreeToRadians(70), false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius), degreeToRadians(270),
        degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
