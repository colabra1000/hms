import 'package:flutter/cupertino.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/MyPlanService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';


class PlanChangeDetailModel extends BaseModel {

  MyPlanService _myPlanService = locator<MyPlanService>();

  int? get currentPlan => _myPlanService.currentPlan;

  String get planName => MyPlanService.getPlanName(currentPlan);

  int? get timeToConfirmation {
    try{
      return 24 - DateTime.now().difference(DateTime.parse(_myPlanService.planSelectionTime)).inHours;

    }catch(e){
      return 0;
    }
  }

  String get subscriptionPrice {
    int planPrice = MyPlanService.getPlanPrice(currentPlan);
    return "\$$planPrice";
  }

  List get detailedAttribute => MyPlanService.getDetailedAttributes(currentPlan);

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

}