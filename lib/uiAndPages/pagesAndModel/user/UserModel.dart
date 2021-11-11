import 'package:flutter/material.dart';
import 'package:c_modal/c_modal.dart';
import 'package:hms/locator.dart';
import 'package:hms/logger.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/models/User.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/ValidationService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/MessageListDisplay/MessageListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/OrganisationListDisplay/OrganisationListDisplayPopperModel.dart';


class UserModel extends BaseModel{

  //logger
  final _log = getLogger("User Page");
  
  //services
  UserService _userService = locator<UserService>();
  ValidationService _validationService = locator<ValidationService>();


  //controllers declaration.
  CModalController cModalController = CModalController();

  late MessageListDisplayPopperModel messageListDisplayPopperModel = MessageListDisplayPopperModel();
  late OrganisationListDisplayPopperModel organisationListDisplayPopperModel = OrganisationListDisplayPopperModel();



  //service getters
  User get user => _userService.user!;
  String get nameOfUser => "${user.firstName} ${user.lastName}";





  late TabController tabController;

  ValueNotifier<bool> popperOpened = ValueNotifier(false);

  bool _confirmValidation = true;


  bool get confirmValidation => _confirmValidation;

  bool _displayDoctorList = false;
  bool get displayDoctorList => _displayDoctorList;


  set displayDoctorList(bool value){
    _displayDoctorList = value;
    notifyListeners();
  }


  void openMessageListDisplayPopper(){

    cModalController.changeModalState = CModalStateChanger(
        state:CModalState.custom2,
        onOutsideClick: (){
          popperOpened.value = false;
        }
    );
    popperOpened.value = true;

  }



  void openDoctorListDisplayPopper() {


    cModalController.changeModalState = CModalStateChanger(
        state:CModalState.custom1,
        fadeDuration: Duration(milliseconds: 700),
        // onOutsideClick: (){
          // popperOpened.value = false;
        // }
    );
    popperOpened.value = true;

  }


  void navigateToLandingPage(BuildContext context) {
    navigationService.navigateToLandingPage(context);

  }




}
