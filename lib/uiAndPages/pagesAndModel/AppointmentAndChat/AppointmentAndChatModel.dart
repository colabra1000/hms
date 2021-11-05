import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/services/DoctorService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_modal/c_modal.dart';

class AppointmentAndChatModel extends BaseModel{

  DoctorService _doctorService  = locator<DoctorService>();
  //keep track of page tab

  String get doctorName => "${_doctorService.doctor.firstName ?? ""} ${_doctorService.doctor.lastName ?? ""}" ;
  String get doctorJobDescription => _doctorService.doctor.jobDescription ?? "";

  AppointmentChatTab _selectedTab = AppointmentChatTab.chat;

  AppointmentChatTab get selectedTab => _selectedTab;

  late TabController tabController;

  CModalController cModalController = CModalController();

  set selectedTab(AppointmentChatTab value) {
    _selectedTab = value;
    notifyListeners();
  }








}