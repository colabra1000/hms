import 'package:flutter/material.dart';
import 'package:hms/logger.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/AppointmentAndChatPage.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/landing/LandingPage.dart';
import 'package:hms/uiAndPages/pagesAndModel/login/LoginDisplayPage.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserPage.dart';

class NavigationService {

  late BaseModel baseModel;

  late BaseModel previousModel;

  Logger _log = getLogger("NavigationService");

  //used to know which model is calling
  NavigationService injectModel(BaseModel baseModel) {
    this.baseModel = baseModel;
    return this;
  }

  Future _setUpNavigation(Future Function() doNavigation) {
    //baseModel catched locally.
    //shouldn't be the newly acquired baseModel but rather the catched one.
    BaseModel baseModel1 = this.baseModel;

    baseModel.disMount();
    return doNavigation().then((value) async {
      //todo handle baseModel could already be destroyed when route is replaced instead of pushed.
      baseModel1.reMount();
    });
  }

  Future navigateToLandingPage(BuildContext context) {
    return _setUpNavigation(() =>
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(
            builder: (context) => LandingPageView()),
            (route)=> false,
        )
    );

  }

  Future navigateToLoginPage(BuildContext context) {
    return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_)=> LoginDisplayPage())
    );
  }

  Future navigateToUserPage(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(
        builder: (context) => UserPage()),
          (route)=> false,
    );
  }

  Future navigateToAppointmentAndChatPage(BuildContext context) {
    return Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => AppointmentAndChatPage()),
    );
  }

}