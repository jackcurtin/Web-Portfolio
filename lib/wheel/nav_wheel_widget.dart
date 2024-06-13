import 'package:flutter/material.dart';
import 'package:portfolio/styles/text_styles.dart';
import 'package:portfolio/wheel/circle_painter.dart';

class NavWheel extends StatelessWidget {
  const NavWheel({super.key});

  Widget _buildCircle(BuildContext context) {
    double circleHeight = MediaQuery.sizeOf(context).height / 1.75;
   return Stack(
      alignment: Alignment.center,
      children: [
       const Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("JACK CURTIN", style: TextStyles.title),
            Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
          ],
        ),
        CustomPaint(
          size: Size(circleHeight, circleHeight),
          painter: CirclePainter(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildCircle(context));
  }
}
