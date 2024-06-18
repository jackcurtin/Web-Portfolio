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

  Duration animationDuration = const Duration(milliseconds: 1200);

  late AnimationController _wheelExpandAnimationController = AnimationController(vsync: this, duration: animationDuration);
  late final AnimationController _textAnimationController = AnimationController(
    duration: const Duration(milliseconds: 800),
  vsync: this,
  );
  late final Animation<Offset> textPositionAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.4),
  ).animate(CurvedAnimation(
    parent: _textAnimationController,
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
    _textAnimationController.forward();
    setState(() {
      showContent = true;
    });
  }



  Widget centerPiece() {
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 800),
    opacity: titleOpacity,
    child: SlideTransition(
      position: textPositionAnimation,
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
        centerPiece(),
        NavWheel(
          onClickItemCallback: onClickMenuItemCallback,
          wheelExpandAnimationController: _wheelExpandAnimationController,
          animationDuration: animationDuration,
          ),
        Visibility(
          visible: false,
          child: Center(
            child: Container(
              height: 500, 
              width: 350, 
              color: Colors.white,
              ),
          ),
          ),
          Visibility(
            visible: showContent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                showContent = false;
                _textAnimationController.reverse();
                _wheelExpandAnimationController.reverse();
            }); 
            }, 
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05, left: 25),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.close,
                size: 50,
                )
              )),
          )
      ],);
  }
}