import 'package:flutter/material.dart';
import 'package:portfolio/constants/blurbs.dart';
import 'package:portfolio/constants/content_keys.dart';
import 'package:portfolio/landingPage/contactForm/contact_form.dart';
import 'package:portfolio/styles/text_styles.dart';
import 'package:portfolio/wheel/nav_wheel_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  double titleOpacity = 0.0;
  double contentOpacity = 0.0;
  bool showContent = false;
  ContentKey contentKey = ContentKey.none;

  Duration fullAnimationDuration = const Duration(milliseconds: 1200);
  Duration halfAnimationDuration = const Duration(milliseconds: 600);

  late final AnimationController _wheelExpandAnimationController = AnimationController(vsync: this, duration: fullAnimationDuration);
  late final AnimationController _textAnimationController = AnimationController(
    duration: const Duration(milliseconds: 800),
  vsync: this,
  );
  late final Animation<Offset> textPositionAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.2),
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
    _textAnimationController.forward().whenComplete(() {
        setState(() {
          contentOpacity = 1;
          contentKey = key;
        });
    });
  }



  Widget titlePiece() {
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 800),
    opacity: titleOpacity,
    child: SlideTransition(
      position: textPositionAnimation,
      child: Center(
        child:  SizedBox(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedOpacity(
                    duration: halfAnimationDuration,
                    opacity: contentOpacity,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          contentOpacity = 0;
                          _textAnimationController.reverse();
                          _wheelExpandAnimationController.reverse();
                          contentKey = ContentKey.none;
                      }); 
                    }, 
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 30,
                    )
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("JACK CURTIN", style: TextStyles.title),
                  Text("MOBILE DEVELOPER", style: TextStyles.subTitle),
                ],
              ),
              AnimatedOpacity(
                duration: halfAnimationDuration,
                opacity: contentOpacity, 
                child: const Icon(
                  Icons.computer_outlined, 
                  size: 30,
                )
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget pageContent(double screenHeight) {
  switch(contentKey) {
    case ContentKey.contact :
      return ContactForm(screenHeight: screenHeight);
    case ContentKey.resume : 
      return Container(height: 100, width: 100, color: Colors.yellow,);
    case ContentKey.gitHub :
      return Container(height: 100, width: 100, color: Colors.green,);
    case ContentKey.linkedIn :
      return Container(height: 100, width: 100, color: Colors.blue,);
    case ContentKey.projects :
      return Container(height: 100, width: 100, color: Colors.purple,);
    case ContentKey.none :
    default :
      return Container();
  }
}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
        NavWheel(
          onClickItemCallback: onClickMenuItemCallback,
          wheelExpandAnimationController: _wheelExpandAnimationController,
          animationDuration: fullAnimationDuration,
          ),
        Center(child: AnimatedOpacity(opacity: contentOpacity, duration: halfAnimationDuration, child: pageContent(screenHeight))),
        titlePiece(),
      ],);
  }
}