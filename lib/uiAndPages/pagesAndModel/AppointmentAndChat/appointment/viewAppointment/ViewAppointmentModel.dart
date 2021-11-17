
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/ErrorService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:date_format/date_format.dart';
import 'package:c_modal/c_modal.dart';


class ViewAppointmentModel extends BaseModel{



  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  AppointmentService _appointmentService = locator<AppointmentService>();
  NotificationService _notificationService = locator<NotificationService>();
  ErrorService _errorService = locator<ErrorService>();

  CModalController pageModalController = CModalController();


  Appointment? get appointment => _appointmentService.appointment;
  set appointment(Appointment? value) => _appointmentService.appointment = value;
  int? get _appointmentId => _appointmentService.appointmentId;


  String get _organizationName => _appointmentService.appointment?.organisationName ?? "";
  String get _appointmentTime => _appointmentService.appointment?.time ?? "";
  int? get appointmentStatus => appointment!.status;

  String get appointmentStatusName{
    int? status = _appointmentService.appointment?.status;
    if(status == null) return "";

    print(status);

    if(status == AppointmentService.PENDING){
      return "pending";
    }else if(status == AppointmentService.ACCEPTED){
      return "accepted";
    }else if(status == AppointmentService.CANCELLED){
      return 'cancelled';
    };

    return "--";
  }
  String get appointmentDate{
    DateTime? date = DateTime.tryParse(_appointmentTime);
    if(date == null) return "";
    return formatDate(date, [dd,"-",M,"-",yyyy,]);
  }
  String get narrateAppointment {
    return
      appointmentStatus == AppointmentService.ACCEPTED ?
      "your appointment with $_organizationName is Scheduled ${getLongAppointmentDateDescription(_appointmentTime)}." :

      appointmentStatus ==  AppointmentService.PENDING?
      "your appointment with $_organizationName booked ${getLongAppointmentDateDescription(_appointmentTime)}"
          " is awaiting confirmation!":
      appointmentStatus ==  AppointmentService.CANCELLED?
      "your appointment with $_organizationName is cancelled." : "";
  }

  String dueDays(){

    int? days = DateTime.tryParse(_appointmentTime)?.difference(DateTime.now()).inDays;

    if(appointmentStatus == AppointmentService.CANCELLED)
      return "--";

    if(days == null) return "";

    if (days < 0){
      return "--";
    }

    return "$days" + " days";

  }
  String getLongAppointmentDateDescription(String? date) {
    if(date == null) return "";
    try{
      return formatDate(DateTime.parse(date) , ['on ', DD," ",d,"'th of ", MM, ", ", yyyy,]);

    }catch(e){
      return "";
    }

  }



  void fetchSingleAppointment() async {

    if(appointment == null && _appointmentId != null){

      await _appointmentService.fetchSingleAppointment(_appointmentService.appointmentId!, this);
      notifyListeners();

    }

  }

  void cancelRemoveAppointment(BuildContext context){
    if(appointmentStatus == AppointmentService.CANCELLED){
      _removeAppointment(context);
    }else{
      _cancelAppointment();
    }
  }

  void _removeAppointment(BuildContext context){
    if(appointment!.id == null){
      return;
    }

    pageModalController.changeModalState = CModalStateChanger(
      state: CModalState.loading
    );

    _api.removeAppointment(id: appointment!.id!, onSuccess: (result){

      _appointmentService.appointments.remove(appointment);
      pageModalController.dismissModal();
      _notificationService.object = appointment;
      appointment = null;
      navigateBack(context);

    }, onError:(e){

      pageModalController.changeModalState = CModalStateChanger(
        state: CModalState.error,
        displayMessage: _errorService.getErrorMessageFrom(e),
      );

    });
  }

  void _cancelAppointment(){


    pageModalController.changeModalState = CModalStateChanger(
        state: CModalState.loading
    );

    _api.cancelAppointment(id: appointment!.id!, onSuccess: (result){

      pageModalController.dismissModal();
      appointment!.status = AppointmentService.CANCELLED;
      notifyListeners();

    }, onError:(e){

      pageModalController.changeModalState = CModalStateChanger(
        state: CModalState.error,
        displayMessage: _errorService.getErrorMessageFrom(e),
      );

    });

  }


  void navigateBack(BuildContext context) {
    _appointmentService.appointment = null;
    Navigator.of(context).pop();
  }





}