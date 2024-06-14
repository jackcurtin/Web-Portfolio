// ignore_for_file: avoid_print

import 'package:circular_motion/circular_motion.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/styles/text_styles.dart';
import 'package:portfolio/wheel/circle_painter.dart';
import 'package:portfolio/wheel/wheel_item.dart';

class NavWheel extends StatefulWidget {
  const NavWheel({super.key});

  @override
  State<NavWheel> createState() => _NavWheelState();
}

class _NavWheelState extends State<NavWheel> with SingleTickerProviderStateMixin {
    
    Duration animationDuration = const Duration(milliseconds: 1500);
    late AnimationController wheelAnimationController = AnimationController(vsync: this, duration: animationDuration)..repeat(reverse: true);
    late final Animation<double> wheelAnimation = CurvedAnimation(
      parent: wheelAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    late AnimationController centerAnimationController = AnimationController(vsync: this, duration: animationDuration)..repeat(reverse: true);
    late final Animation<double> centerAnimation = CurvedAnimation(
      parent: centerAnimationController,
      curve: Curves.easeIn,
    );

@override
  void initState() {
    // animationController.forward();
    super.initState();
  }

    @override
  void dispose() {
    wheelAnimationController.dispose();
    centerAnimationController.dispose();
    super.dispose();
  }

  Widget _buildCircle(BuildContext context) {
    double circleHeight = MediaQuery.sizeOf(context).height / 1.5;
   return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(circleHeight, circleHeight),
          painter: CirclePainter(),
        ),
      Center(
        child: SizedBox(
          height: circleHeight + 54,
          width: circleHeight + 54,
          child: CircularMotion(
            speedRunEnabled: false,
             centerWidget: FadeTransition(
              opacity: centerAnimation,
               child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("JACK CURTIN", style: TextStyles.title),
                    Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
                  ],
                ),
             ),
              children: [
                WheelItem(icon: Icons.question_mark_rounded),
                WheelItem(icon:Icons.edit_document),
                WheelItem(icon:Icons.person_search_outlined),
                WheelItem(icon:Icons.work_history_outlined),
                WheelItem(icon:Icons.mail)
              ],
           ),
        ),
      ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildCircle(context));
  }
}
