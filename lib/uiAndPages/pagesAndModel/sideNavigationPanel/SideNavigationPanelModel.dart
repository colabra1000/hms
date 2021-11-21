import 'package:flutter/cupertino.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/MyPlanService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';


class SideNavigationPanelModel extends BaseModel {

  Function()? onDeactivate;

  bool _activate = false;

  bool get activate => _activate;


  set activate(bool value) {
    _activate = value;
    notifyListeners();
  }

  void navigateBack(BuildContext context) {
    // Navigator.of(context).pop();
  }



}