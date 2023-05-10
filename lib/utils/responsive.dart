import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Responsive {
  double textScalleFactor(BuildContext context, double textSize) {
    return MediaQuery.of(context).textScaleFactor * textSize;
  }

  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double fractionalWidth(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.width * fraction;
  }

  double fractionalHeight(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.height * fraction;
  }

  double actualScreenHeight(BuildContext context, double appBarHeight,
      {double extra = 0}) {
    return MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQuery.of(context).viewPadding.top -
        extra;
  }
}
