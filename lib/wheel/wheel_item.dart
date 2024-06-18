// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:portfolio/constants/content_keys.dart';

class WheelItem extends StatefulWidget {
  final IconData icon;
  final AnimationController wheelExpandAnimationController;
  final Animation<double> wheelItemFadeAnimation;
  final Function onClickCallback;
  final ContentKey contentKey;
  const WheelItem({ required this.icon, required this.wheelExpandAnimationController, required this.wheelItemFadeAnimation, required this.onClickCallback, required this.contentKey, super.key });

  @override
  State<WheelItem> createState() => _WheelItemState();
}

class _WheelItemState extends State<WheelItem> {
  double radius = 30;
  Color color = const Color.fromARGB(255, 113, 160, 213);

  Future<void> onClickItem() async {
    await expandAnimation();
    widget.onClickCallback(widget.contentKey);
  }
  
  Future<void> expandAnimation() async {
      print("expand animation");
    try {
      await widget.wheelExpandAnimationController.forward();
    } on TickerCanceled {
      throw Exception("TICKER CANCELLED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.wheelItemFadeAnimation,
      child: InkWell(
        onTap: () => onClickItem(),
        onHover: (hover) {
          setState(() {
            if (hover) {
              radius = 32;
              color = const Color.fromARGB(255, 188, 212, 240);
            } else {
              radius = 30;
              color = const Color.fromARGB(255, 113, 160, 213);
            }
          });
        },
        child: CircleAvatar(
          radius: radius,
          backgroundColor: color,
          child: Icon(
            widget.icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}