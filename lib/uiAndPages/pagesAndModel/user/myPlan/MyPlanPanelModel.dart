import 'package:flutter/material.dart';
import 'package:c_ui/c_ui.dart';
import 'package:hms/locator.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelView.dart';

class MyPlanPanelModel extends BaseModel {

  late UserModel userModel;


  void openMyPlanListDisplayPopper() {


    userModel.openMyPlanListDisplayPopper().then((value) {
      // notifyListeners();
    });

  }

}