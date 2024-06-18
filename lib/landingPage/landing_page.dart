import 'package:flutter/material.dart';
import 'package:portfolio/styles/text_styles.dart';
import 'package:portfolio/wheel/nav_wheel_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  bool showContent = false;
    late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> positionAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.4),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  void onClickMenuItemCallback() {
    setState(() {
      showContent = true;
    });
  }



  Widget centerPiece() {
  return  SlideTransition(
    position: positionAnimation,
    child: Align(
      alignment: showContent ? Alignment.topCenter : Alignment.center,
      child:  Column(
        mainAxisAlignment: showContent ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: const [
          Text("JACK CURTIN", style: TextStyles.title),
          Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        centerPiece(),
        NavWheel(onClickItemCallback: onClickMenuItemCallback,)
      ],);
  }
}