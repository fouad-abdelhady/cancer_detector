import 'package:flutter/material.dart';

import '../constants/strings.dart';

class Validations {
  String? validateText(
    String? text,
  ) {
    if (text == null || text.isEmpty) {
      return Strings().emptyTextField;
    }
    if (text.length <= 2) {
      return Strings().invalidDisplayName;
    }
  }
}
