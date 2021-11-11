import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/services/OrganisationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_modal/c_modal.dart';

class AppointmentAndChatModel extends BaseModel{

  OrganisationService _organisationService  = locator<OrganisationService>();
  //keep track of page tab

  String get organisationName => "${_organisationService.organisation.name ?? ""}" ;
  String get doctorJobDescription => "to be filled";

  AppointmentChatTab _selectedTab = AppointmentChatTab.chat;

  AppointmentChatTab get selectedTab => _selectedTab;

  set selectedTab(AppointmentChatTab value) {
    _selectedTab = value;
    notifyListeners();
  }


  late TabController tabController;

  CModalController cModalController = CModalController();

  //saves the chat model.
  ChatModel? chatModel;










}