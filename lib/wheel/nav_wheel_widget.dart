// ignore_for_file: avoid_print

import 'package:circular_motion/circular_motion.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/styles/text_styles.dart';
import 'package:portfolio/wheel/circle_painter.dart';

class NavWheel extends StatelessWidget {
  const NavWheel({super.key});

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
             centerWidget: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("JACK CURTIN", style: TextStyles.title),
                  Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
                ],
              ),
              children: [
                buildMenuOption(Icons.question_mark_rounded),
                buildMenuOption(Icons.edit_document),
                buildMenuOption(Icons.person_search_outlined),
                buildMenuOption(Icons.work_history_outlined),
                buildMenuOption(Icons.mail)
              ],
           ),
        ),
      ),
      ],
    );
  }

  Widget buildMenuOption(IconData icon) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Color.fromARGB(255, 113, 160, 213),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        onPressed: () {
          print("ok");
        },
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Center(child: _buildCircle(context));
  }
}
