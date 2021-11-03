
import 'package:c_ui/c_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';

class LandingPageDocument{
  static Widget doc1 = SharedUi.normalText(
     "Hoslite hospital incorporation", maxLine: 5
  );

  static Widget doc2 = SharedUi.smallText(
    "Welcome to the Official Hospital Registration"
        " Portal (OHCRP) of Hoslite Incorporation,"
        " we aim to give the best service. Please use the links"
        " below for more information.", maxLine: 5, size: 18
  );

  static Widget doc3 = CText("2021 Hoslite Incorporation Chairman(HIC), Nigeria",
    color: Colors.green.shade50,
  );

}
