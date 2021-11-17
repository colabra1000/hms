import 'package:c_modal/src/CModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/ErrorService.dart';
import 'package:hms/services/OrganisationService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_input/src/CInputController.dart';
import 'package:hms/variables/DataHelper.dart';
import 'package:hms/variables/GlobalData.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_format/date_format.dart';



class AppointmentModel extends BaseModel{

  // service getters
  ErrorService _errorService = locator<ErrorService>();
  UserService _userService = locator<UserService>();
  // used when creating new appointment.
  OrganisationService _organisationService = locator<OrganisationService>();
  AppointmentService _appointmentService = locator<AppointmentService>();
  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  // controllers
  late CModalController pageModalController;


  // service getters.
  List get appointments =>  _appointmentService.appointments;
  set appointments (List appointments){
    _appointmentService.appointments = appointments;
  }

  Appointment? _appointment;

  // ui state.
  AppointmentBookingState _appointmentBookingState = AppointmentBookingState.idle;

  AppointmentBookingState get appointmentBookingState => _appointmentBookingState;

  // State of the ui.
  set appointmentBookingState(AppointmentBookingState value) {
    _appointmentBookingState = value;
    notifyListeners();
  }

  CInputController appointmentNoteInputController = CInputController();

  String get organisationName => "${_organisationService.organisation.name}";

  String get appointmentNote => appointmentNoteInputController.selectedValue ?? "...";

  CalendarFormat calendarFormat = CalendarFormat.month;

  String getLongAppointmentDateDescription(String? date) {
    if(date == null) return "";
    try{
      return formatDate(DateTime.parse(date) , ['for ', DD," ",d,"'th of ", MM, ", ", yyyy,]);

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




  // appointment Date.
  // holds date picked by the calender.
  DateTime? _appointmentDate;

  DateTime? get appointmentDate => _appointmentDate;

  set appointmentDate(DateTime? value) {
    _appointmentDate = value;
    notifyListeners();
  }




  void setNewAppointment(){
    _appointment = null;
    _appointment = Appointment();

    _appointment!.time = _appointmentDate != null ?
    _appointmentDate!.toString() : "";

    _appointment!.status = 0;
    _appointment!.userId = _userService.user.id;
    _appointment!.organisationId = _organisationService.organisation.id;
    _appointment!.message = appointmentNote;

  }


  void addNewAppointment() {

    pageModalController.changeModalState = CModalStateChanger(
      state: CModalState.loading,
    );

    _api.saveAppointment(payload: _appointment!.toJson(), onSuccess:(result){

      Appointment appointment = Appointment.fromJson(result);
      appointments.insert(0, appointment);
      notifyListeners();
      _appointment = null;

      pageModalController.dismissModal();

    }, onError: (e){

      pageModalController.changeModalState = CModalStateChanger(
        state: CModalState.error,
        displayMessage: _errorService.getErrorMessageFrom(e),
      );

    });
  }


  String getAppointmentStatus(Appointment appointment){

    switch(appointment.status){
      case AppointmentService.CANCELLED:
        return "cancelled";
      case AppointmentService.PENDING:
        return "pending";
      case AppointmentService.ACCEPTED:
        return getShortAppointmentDateFormat(appointment.time);
      default:
        return "";
    }

  }

  // _sortAppointments(){
  //   _appointments.sort((a, b){
  //     if(a.status == 0) return -1;
  //     else return 0;
  //   });
  //
  //   _appointments.sort((a, b){
  //     print(a.status);
  //     if(a.status == 2) return 1;
  //     else return 0;
  //   });
  // }


  void navigateToViewAppointment(BuildContext context, Appointment appointment) {

    _appointmentService.appointment = appointment;
    navigationService.navigateToViewAppointment(context).then((value) => notifyListeners());
  }

  void resetDate() {
    appointmentDate = DateTime.now();
  }







}