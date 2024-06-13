import 'package:flutter/material.dart';
import 'package:portfolio/wheel/circle_painter.dart';

class NavWheel extends StatelessWidget {
  const NavWheel({super.key});

  Widget _buildCircle(BuildContext context) {
    double _height = MediaQuery.sizeOf(context).height / 2;
    return CustomPaint(
      size: Size(_height, _height),
      painter: CirclePainter(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCircle(context);
  }
}
