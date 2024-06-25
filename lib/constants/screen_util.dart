import 'package:flutter/material.dart';

class ScreenUtility {
  BuildContext context;

  ScreenUtility(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isMobileScreen => width < 400;
}