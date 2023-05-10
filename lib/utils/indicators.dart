import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Indicators {
  Widget getLoadingIndicator(
      {double dimention = 16, Color color = AppColors.secondary}) {
    return SizedBox(
      height: dimention,
      width: dimention,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }

  void showSnacBarWithMessage(
      {required BuildContext context,
      required String message,
      Color background = AppColors.secondary}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: background),
    );
  }
}
