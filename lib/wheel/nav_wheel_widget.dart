// ignore_for_file: avoid_print

import 'package:circular_motion/circular_motion.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/content_keys.dart';
import 'package:portfolio/constants/screen_util.dart';
import 'package:portfolio/wheel/circle_painter.dart';
import 'package:portfolio/wheel/wheel_item.dart';

class NavWheel extends StatefulWidget {
  final Function onClickItemCallback;
  final AnimationController wheelExpandAnimationController;
  final Duration? animationDuration;
  const NavWheel({required this.onClickItemCallback, required this.wheelExpandAnimationController, this.animationDuration, super.key});

  @override
  State<NavWheel> createState() => _NavWheelState();
}

class _NavWheelState extends State<NavWheel> with TickerProviderStateMixin {
    Duration bloomDuration = const Duration(milliseconds: 800);
    bool pageBloomed = false;
    /// Controllers and Animation for the inital menu wheel load
    late AnimationController wheelBloomAnimationController = AnimationController(vsync: this, duration: bloomDuration);
    late final Animation<double> wheelBloomAnimation = Tween<double>(begin: 0, end: 0.75).animate(wheelBloomAnimationController);

    /// Controller and Animation tweens for selecting menu items
    late final Animation<double> wheelExpandAnimation = Tween<double>(begin: 0.75, end: 1).animate(CurvedAnimation(
        parent: widget.wheelExpandAnimationController, 
        curve: const Interval(
          0.4,
          1,
          curve: Curves.ease
          )
        )
      );
    late final Animation<double> wheelFadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: widget.wheelExpandAnimationController, 
        curve: const Interval(
          0.4,
          1,
          curve: Curves.ease
          )
        )
      );
    late final Animation<double> wheelItemFadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: widget.wheelExpandAnimationController, 
        curve: const Interval(
          0,
          0.4,
          curve: Curves.ease
          )
        )
      );

    /// Controllers and Animation for the center widget
    late AnimationController fadeAnimationController = AnimationController(vsync: this, duration: widget.animationDuration);
    late final Animation<double> fadeAnimation = CurvedAnimation(
      parent: fadeAnimationController,
      curve: Curves.easeIn,
    );

@override
  void initState() {
    bloomAnimation();
    super.initState();
  }

    @override
  void dispose() {
    wheelBloomAnimationController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  Future<void> bloomAnimation() async {
    try {
      await wheelBloomAnimationController.forward().whenComplete(() => fadeAnimationController.forward());
      setState(() {
        pageBloomed = true;
      });
    } on TickerCanceled {
      throw Exception("TICKER CANCELLED");
    }
  }

    Future<void> expandAnimation() async {
      print("expand animation");
    try {
      await widget.wheelExpandAnimationController.forward();
    } on TickerCanceled {
      throw Exception("TICKER CANCELLED");
    }
  }

  Widget _buildCircle(BuildContext context) {
   double width = ScreenUtility(context).width;
   double height = ScreenUtility(context).height;
   bool isMobile = ScreenUtility(context).isMobileScreen;
   return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: height * .75, maxHeight: height * .75),
          child: FadeTransition(
            opacity: wheelFadeAnimation,
            child: AnimatedBuilder(
              animation: pageBloomed ? wheelExpandAnimation : wheelBloomAnimation,
              builder: (context, _) {
                double animatedSizing = pageBloomed ? wheelExpandAnimation.value : wheelBloomAnimation.value;
                return CustomPaint(
                  size: Size(width * animatedSizing, width * animatedSizing),
                  painter: isMobile ? CirclePainterMobile() : CirclePainter(),
                );
              }
            ),
          ),
        ),
      Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: height * .815, 
            maxHeight: height * .815
          ),
          height: width * 0.815,
          width: width * 0.815,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: CircularMotion(
              speedRunEnabled: false,
               centerWidget: const SizedBox(),
                children: [
                  WheelItem(
                    icon: Icons.mail, 
                    wheelExpandAnimationController: widget.wheelExpandAnimationController, 
                    wheelItemFadeAnimation: wheelItemFadeAnimation,
                    onClickCallback: widget.onClickItemCallback,
                    contentKey: ContentKey.contact,
                  ),
                  WheelItem(
                    icon:Icons.edit_document, 
                    wheelExpandAnimationController: widget.wheelExpandAnimationController, 
                    wheelItemFadeAnimation: wheelItemFadeAnimation,
                    onClickCallback: widget.onClickItemCallback,
                    contentKey: ContentKey.resume,
                  ),
                  WheelItem(
                    icon:Icons.person_search_outlined, 
                    wheelExpandAnimationController: widget.wheelExpandAnimationController, 
                    wheelItemFadeAnimation: wheelItemFadeAnimation,
                    onClickCallback: widget.onClickItemCallback,
                    contentKey: ContentKey.gitHub,
                    useImage: true,
                    imagePath: "lib/assets/githubIcon.svg",
                  ),
                  WheelItem(
                    icon:Icons.work_history_outlined, 
                    wheelExpandAnimationController: widget.wheelExpandAnimationController,
                    wheelItemFadeAnimation: wheelItemFadeAnimation,
                    onClickCallback: widget.onClickItemCallback,
                    contentKey: ContentKey.linkedIn,
                    useImage: true,
                    imagePath: "lib/assets/linkedInIcon.svg",
                  ),
                  WheelItem(
                    icon:Icons.folder, 
                    wheelExpandAnimationController: widget.wheelExpandAnimationController, 
                    wheelItemFadeAnimation: wheelItemFadeAnimation,
                    onClickCallback: widget.onClickItemCallback,
                    contentKey: ContentKey.projects,
                  )
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
