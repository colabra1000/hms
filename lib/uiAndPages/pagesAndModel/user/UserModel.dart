import 'package:flutter/material.dart';
import 'package:c_modal/c_modal.dart';
import 'package:hms/locator.dart';
import 'package:hms/logger.dart';
import 'package:hms/services/ValidationService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class UserModel extends BaseModel{

  //logger
  final _log = getLogger("User Page");
  
  //services
  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  
  //service getters
  ValidationService _validationService = locator<ValidationService>();

  //controllers declaration.
  CModalController cModalController = CModalController();

  AccessDoctorListDisplayController accessDoctorListDisplayController = AccessDoctorListDisplayController();


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


  void openUpdateInformationPopper(){

    cModalController.changeModalState = CModalStateChanger(
        state:CModalState.custom2,
        onOutsideClick: (){
          popperOpened.value = false;
        }
    );
    popperOpened.value = true;

  }



  void openChangeDoctorPopper() {


    cModalController.changeModalState = CModalStateChanger(
        state:CModalState.custom1,
        onOutsideClick: (){
          popperOpened.value = false;
        }
    );
    popperOpened.value = true;

  }





  set confirmValidation(bool value) {
    _confirmValidation = value;
    notifyListeners();
  }

  void navigateToLandingPage(BuildContext context) {
    navigationService.navigateToLandingPage(context);

  }

  Future<void> loadDoctorList() async {

    //   _setDisplayDoctorList(false);
    //
    // _api.fetchDoctors(onError: (e){}, onSuccess: (result){
    //
    //   print("zimmer");
    //   _setDisplayDoctorList(true);
    //
    //
    // });
    await Future.delayed(Duration(seconds: 5));
    displayDoctorList = true;


  }

}

class AccessDoctorListDisplayController{

  Function()? onOpen;

}