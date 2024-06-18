import 'package:flutter/material.dart';
import 'package:portfolio/constants/content_keys.dart';
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
  ContentKey contentKey = ContentKey.none;

  Duration animationDuration = const Duration(milliseconds: 1200);

  late final AnimationController _wheelExpandAnimationController = AnimationController(vsync: this, duration: animationDuration);
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
      setState(() {});
      }
    );
  }

  void onClickMenuItemCallback(ContentKey key) {
    print("key : $key");
    _textAnimationController.forward();
    setState(() {
      showContent = true;
      contentKey = key;
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

Widget pageContent() {
  switch(contentKey) {
    case ContentKey.about :
      return Container(height: 100, width: 100, color: Colors.red,);
    case ContentKey.resume : 
      return Container(height: 100, width: 100, color: Colors.yellow,);
    case ContentKey.gitHub :
      return Container(height: 100, width: 100, color: Colors.green,);
    case ContentKey.linkedIn :
      return Container(height: 100, width: 100, color: Colors.blue,);
    case ContentKey.contact :
      return Container(height: 100, width: 100, color: Colors.purple,);
    case ContentKey.none :
    default :
      return Container();
  }
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
        Center(child: pageContent()),
        Visibility(
          visible: showContent,
          child: GestureDetector(
            onTap: () {
              setState(() {
              showContent = false;
              _textAnimationController.reverse();
              _wheelExpandAnimationController.reverse();
              contentKey = ContentKey.none;
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