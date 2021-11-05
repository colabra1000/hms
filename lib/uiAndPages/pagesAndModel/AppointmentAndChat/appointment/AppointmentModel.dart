import 'package:c_modal/src/CModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/ChatAutomationService.dart';
import 'package:hms/services/DoctorService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_input/src/CInputController.dart';
import 'package:hms/variables/DataHelper.dart';
import 'package:hms/variables/GlobalData.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_format/date_format.dart';



class AppointmentModel extends BaseModel{

  //service getters
  UserService _userService = locator<UserService>();
  DoctorService _doctorService = locator<DoctorService>();

  //controllers
  late CModalController pageModalController;



  late List _appointments;
  List get appointments => _appointments;

  Appointment? _appointment;

  AppointmentBookingState _appointmentBookingState = AppointmentBookingState.idle;

  AppointmentBookingState get appointmentBookingState => _appointmentBookingState;

  CInputController appointmentNoteInputController = CInputController();

  String get doctorName => "${_doctorService.doctor.firstName ?? ""} ${_doctorService.doctor.lastName ?? ""}";

  String get appointmentNote => appointmentNoteInputController.selectedValue ?? "...";

  CalendarFormat calendarFormat = CalendarFormat.month;

  // String get longAppointmentDateDescription {
  //
  //   if(appointmentDate == null) return "";
  //
  //   return formatDate(appointmentDate!, ['on ', DD," ",d,"'th of ", MM, ", ", yyyy,]);
  //
  // }

  String getLongAppointmentDateDescription(String? date) {
    if(date == null) return "";
    try{
      return formatDate(DateTime.parse(date) , ['on ', DD," ",d,"'th of ", MM, ", ", yyyy,]);

    }catch(e){
      return "";
    }

  }

  String getShortAppointmentDateFormat(String? date) {
    if(date == null) return "";
    try{
      return formatDate(DateTime.parse(date) , [DD," ",d,"'th ", MM, ", ", yyyy,]);

    }catch(e){
      return "";
    }

  }



  set appointmentBookingState(AppointmentBookingState value) {
    _appointmentBookingState = value;
    notifyListeners();
  }

  //appointment Date
  DateTime? _appointmentDate;

  DateTime? get appointmentDate => _appointmentDate;

  set appointmentDate(DateTime? value) {
    _appointmentDate = value;
    notifyListeners();
  }

  void resetDate() {
    _appointmentDate = DateTime.now();
  }






  void setNewAppointment(){
    _appointment = null;
    _appointment = Appointment();

    _appointment!.time = _appointmentDate != null ?
    _appointmentDate!.toString() : "";

    _appointment!.accepted = false;
    _appointment!.doctorId = _doctorService.doctor.id;
    _appointment!.doctorName = DataHelper.getDoctorName(_appointment!.doctorId, GlobalData.doctors);
    _appointment!.message = appointmentNote;

  }


  void addNewAppointment() {
    appointments.insert(0, _appointment);
    notifyListeners();
    _appointment = null;
  }


  _sortAppointments(){
    _appointments.sort((a, b){
      if(a.accepted) return -1;
      else return 1;
    });
  }


  AppointmentModel(){

    _appointments = _userService.user!.appointments;

    _sortAppointments();

  }





}