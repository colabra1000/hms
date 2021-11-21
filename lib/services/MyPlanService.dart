import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class MyPlanService {

  UserService _userService = locator<UserService>();

  static const int AVALON = 0;
  static const int SEMI = 1;
  static const int ROD = 2;

  static const int _avalonPrice = 70;
  static const int _semiPrice = 50;
  static const int _rodPrice = 25;

  late String planSelectionTime;

  static ColorType getPlanColor(int? planType){

    switch(planType){
      case AVALON:
        return ColorType.dark;
      case SEMI:
        return ColorType.info;
      case ROD:
        return ColorType.outlier;
      default:
        return ColorType.secondary;
    }

  }

  static String getPlanName(int? i){
    switch(i){
      case MyPlanService.AVALON :
        return "Avalon";

      case MyPlanService.SEMI :
        return "Semi";

      case MyPlanService.ROD :
        return "Rod";
      default:
        return "";
    }
  }

  static List getAttributes(int? i){
    switch(i){
      case MyPlanService.AVALON :
        return MyPlanService._avalonPlanAttributes;

      case MyPlanService.SEMI :
        return MyPlanService._semiPlanAttributes;

      case MyPlanService.ROD :
        return MyPlanService._rodPlanAttributes;

      default:
        return [];

    }
  }

  static List getDetailedAttributes(int? i){
    switch(i){
      case MyPlanService.AVALON :
        return [
          ..._avalonPlanAttributes.skip(2),
          ..._semiPlanAttributes.skip(2),
          ..._rodPlanAttributes.skip(1),
        ];


      case MyPlanService.SEMI :
        return [
          ..._semiPlanAttributes.skip(2),
          ..._rodPlanAttributes.skip(1),
        ];

      case MyPlanService.ROD :
        return [
          ..._rodPlanAttributes.skip(1)
        ];

      default:
        return [];

    }
  }

  static int getPlanPrice(int? i){
    switch(i){
      case MyPlanService.AVALON :
        return _avalonPrice;

      case MyPlanService.SEMI :
        return _semiPrice;

      case MyPlanService.ROD :
        return _rodPrice;
      default:
        return 0;
    }
  }












  int? get currentPlan => _userService.user.myPlan;

  set currentPlan(int? value){
    _userService.user.myPlan = value;
  }

  // int? currentlySelectedPlan;

  static const List<String> _avalonPlanAttributes = [
    "imba",
    "EveryThing in Semi & Rod plus",
    "Priority tech support",
    "Access on all device",
    "Premium License",
  ];

  static const List<String> _semiPlanAttributes = [
    "recommended",
    "Everything in Rod plus",
    "Multi-factor options",
    "Layered dynamics",
    "LastPass for application",
  ];

  static const List<String> _rodPlanAttributes = [
    "nerfed",
    "Integral Segmentation",
    "One to One Communication",
    "Emergency Access",
    "Rigorous Access",
    "Seamless interface",
  ];





  static List<String> _detailedAvalonPlanAttributes = [
    ..._avalonPlanAttributes.skip(2),
    ..._semiPlanAttributes.skip(2),
    ..._rodPlanAttributes.skip(1),
  ];



  static List<String> _detailedSemiPlanAttributes = [
    ..._semiPlanAttributes.skip(2),
    ..._rodPlanAttributes.skip(1),
  ];

  static List<String> _detailedRodPlanAttributes = [
    ..._rodPlanAttributes.skip(1),
  ];



}