import 'package:flutter/material.dart';
import 'package:portfolio/styles/text_styles.dart';
import 'package:portfolio/wheel/nav_wheel_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  double titleOpacity = 0.0;
  bool showContent = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
  vsync: this,
  );
  late final Animation<Offset> positionAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.4),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () { 
      titleOpacity = 1;
      setState(() {
        
      });
      }
    );
  }

  void onClickMenuItemCallback() {
    _controller.forward();
    setState(() {
      showContent = true;
    });
  }



  Widget centerPiece() {
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 800),
    opacity: titleOpacity,
    child: SlideTransition(
      position: positionAnimation,
      child: const Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("JACK CURTIN", style: TextStyles.title),
            Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        centerPiece(),
        NavWheel(onClickItemCallback: onClickMenuItemCallback),
        Visibility(
          visible: showContent,
          child: Center(
            child: Container(
              height: 500, 
              width: 350, 
              color: Colors.white,
              ),
          ),
          ),
      ],);
  }
}