import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class AppointmentAndChatModel extends BaseModel{

  //keep track of page tab
  AppointmentChatTab _selectedTab = AppointmentChatTab.chat;

  AppointmentChatTab get selectedTab => _selectedTab;

  late TabController tabController;

  set selectedTab(AppointmentChatTab value) {
    _selectedTab = value;
    notifyListeners();
  }






}