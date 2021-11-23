import 'package:flutter/cupertino.dart';
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

  Future navigateToAccountInformationPage(BuildContext context) {

    return navigationService.navigateToAccountInformationPage(context);


  }



}