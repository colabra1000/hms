import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Organisation.dart';
import 'package:hms/services/OrganisationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class OrganisationListDisplayPopperModel extends BaseModel{

  OrganisationService _organisationService = locator<OrganisationService>();

  void onOpen() async{

    if(_organisationService.organisations == null){
      await _organisationService.fetchOrganisations(this);
      if(mounted) notifyListeners();
    }


  }

  List? get organisations => _organisationService.organisations;

  CInputController searchInputController = CInputController();


  void navigateToAppointmentAndChatPage(BuildContext context, {required Organisation organisation}) {
    _organisationService.organisation = organisation;
    navigationService.navigateToAppointmentAndChatPage(context);
  }

}


