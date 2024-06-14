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

class _NavWheelState extends State<NavWheel> with TickerProviderStateMixin {
    Duration animationDuration = const Duration(milliseconds: 1500);
    /// Controllers and Animation for the menu wheel
    late AnimationController wheelAnimationController = AnimationController(vsync: this, duration: animationDuration)..repeat(reverse: true);
    late final Animation<double> wheelAnimation = Tween<double>(begin: 0, end: 0.75).animate(wheelAnimationController);

    /// Controllers and Animation for the center widget
    late AnimationController fadeAnimationController = AnimationController(vsync: this, duration: animationDuration)..repeat(reverse: true);
    late final Animation<double> fadeAnimation = CurvedAnimation(
      parent: fadeAnimationController,
      curve: Curves.easeIn,
    );

@override
  void initState() {
    loadAnimation();
    super.initState();
  }

    @override
  void dispose() {
    wheelAnimationController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  Future<void> loadAnimation() async {
    try {
      await wheelAnimationController.forward().whenComplete(() => fadeAnimationController.forward());
    } on TickerCanceled {
      
    }
  }

  Widget _buildCircle(BuildContext context) {
   double height = MediaQuery.sizeOf(context).height;
   return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: wheelAnimation,
          builder: (context, _) {
            return CustomPaint(
              size: Size(height * wheelAnimation.value, height * wheelAnimation.value),
              painter: CirclePainter(),
            );
          }
        ),
      Center(
        child: SizedBox(
          height: height * 0.815,
          width: height * 0.815,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: const CircularMotion(
              speedRunEnabled: false,
               centerWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("JACK CURTIN", style: TextStyles.title),
                    Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
                  ],
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
      ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildCircle(context));
  }
}
