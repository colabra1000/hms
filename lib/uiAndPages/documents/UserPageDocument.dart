
import 'package:c_ui/c_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';

class UserPageDocument{
  static Widget greetings =
  Row(
    children: [
      SharedUi.normalText(
      "Hello", bold: true),

      Icon(Icons.emoji_emotions_sharp, color: SharedUi.getColor(ColorType.outlier), size: 30,)
    ],
  );


}
