import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Organisation.dart';
import 'package:hms/services/OrganisationService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class OrganisationListDisplayPopperModel extends BaseModel{


  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  OrganisationService _organisationService = locator<OrganisationService>();

  void onOpen() async{

    if(_organisationService.organisations == null)
      await _organisationService.fetchOrganisations(this);

    if(mounted){
      loading = false;
    }
  }

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  List get organisations => _organisationService.organisations!;

  CInputController searchInputController = CInputController();


  void navigateToAppointmentAndChatPage(BuildContext context, {required Organisation doctor}) {
    _organisationService.organisation = doctor;
    navigationService.navigateToAppointmentAndChatPage(context);
  }

  // //should not return error;
  // //should keep trying to fetch until value is gotten.
  // Future<bool> fetchOrganisations() async {
  //
  //   await _fetch();
  //   return true;
  // }
  //
  //
  // //recursively fetching indefinitely until doctors is returned
  // _fetch(){
  //
  //   return _api.fetchOrganisations(
  //       onSuccess: (result){
  //
  //         organisations = Organisation().toList(result);
  //
  //       }, onError: (e)async{
  //       if(!this.mounted){
  //         return false;
  //       }
  //       await Future.delayed(Duration(seconds: 2));
  //       await _fetch();
  //   });
  // }

}


