import 'package:flutter/cupertino.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/ChatAutomationService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_input/src/CInputController.dart';



class AppointmentModel extends BaseModel{

  UserService _userService = locator<UserService>();

  //service getters
  late List _appointments;
  List get appointments => _appointments;

  bool _bookingAppointment = false;

  bool get bookingAppointment => _bookingAppointment;

  set bookingAppointment(bool value) {
    _bookingAppointment = value;
    notifyListeners();
  }

  AppointmentModel(){

    _appointments = _userService.user!.appointments ?? [];

    _appointments.sort((a, b){
      if(a.accepted) return -1;
      else return 1;
    });

  }


}