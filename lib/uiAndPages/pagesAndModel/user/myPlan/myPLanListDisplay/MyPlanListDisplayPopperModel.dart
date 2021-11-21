
import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Notification.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/MyPlanService.dart';
import 'package:hms/services/NavigationService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:date_format/date_format.dart';

class MyPlanListDisplayPopperModel extends BaseModel{

  MyPlanService _myPlanService = locator<MyPlanService>();

  CInputController searchInputController = CInputController();

  //redundant.
  void onOpen() async{

  }

  int? _currentlySelectedPlan;

  int? get currentlySelectedPlan => _currentlySelectedPlan;

  set currentlySelectedPlan(int? value) {
    _currentlySelectedPlan = value;
    notifyListeners();
  }

  int? get currentPlan => _myPlanService.currentPlan;



  void navigateToVerifyPlanChangePage(BuildContext context, int? i) {


    _myPlanService.planSelectionTime = DateTime.now().toString();
    _myPlanService.currentPlan = currentlySelectedPlan;
    currentlySelectedPlan = null;
    navigationService.navigateToVerifyPlanChangePage(context)
        .then((value) {
          currentlySelectedPlan = _myPlanService.currentPlan;
              notifyListeners();
        }
    );

  }

  String getPrice(int i) {
      int planPrice = MyPlanService.getPlanPrice(i);
      return "\$$planPrice/month";
  }

}


