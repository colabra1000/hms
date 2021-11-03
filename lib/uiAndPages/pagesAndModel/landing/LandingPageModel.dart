import 'package:flutter/material.dart';
import 'package:c_modal/c_modal.dart';
import 'package:hms/locator.dart';
import 'package:hms/logger.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class LandingPageModel extends BaseModel {

  final _log = getLogger("Landing Page");
  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  //controllers declaration.
  CModalController cModalController = CModalController();

  void navigateToLoginPage(BuildContext context) {

  }


}