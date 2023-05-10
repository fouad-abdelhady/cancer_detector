import 'package:cancer_detector/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

extension textStyle on Text {
  Text largeHeadline(BuildContext context,
      {Color textColor = AppColors.secondary, fontSize = largeHeadLineSize}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontFamily: appNameFontFamily,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }

  Text largeHeadline1(BuildContext context,
      {Color textColor = AppColors.secondary, fontSize = largeHeadlineSize1}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontFamily: appNameFontFamily,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }

  Text largeHeadline2(BuildContext context,
      {Color textColor = AppColors.secondary, fontSize = largeHeadlineSize2}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontFamily: appNameFontFamily,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }

  Text applyColor({Color textColor = AppColors.secondary}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(color: textColor),
    );
  }

  Text applyBold(BuildContext context,
      {Color textColor = AppColors.secondary, var fontSize = 18.0}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }
}

const appNameFontFamily = 'Varta';
const largeHeadLineSize = 50;
const largeHeadlineSize1 = 40;
const largeHeadlineSize2 = 30;
