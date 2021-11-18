import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';


class AppointmentService {

  static const int PENDING = 0;
  static const int ACCEPTED = 1;
  static const int CANCELLED = 2;
  static const int REMOVED = 3;

  static getAppointmentStatusColor(int? appointmentStatus) {
    switch(appointmentStatus){
      case PENDING:
        return ColorType.warning;
      case ACCEPTED:
        return ColorType.success;
      case CANCELLED:
        return ColorType.error;
      default:
        return ColorType.dark;
    }
  }


  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  UserService userService = locator<UserService>();


  int? appointmentId;

  Appointment? appointment;

  List get appointments => userService.user.appointments ?? getAppointments();

  set appointments(List appointments){
    userService.user.appointments = appointments;
  }

  List getAppointments(){
    userService.user.appointments = [];
    return userService.user.appointments!;
  }



  Future<bool> fetchSingleAppointment(int id, BaseModel model) async {

    await _fetchSingleAppointment(id, model);
    return true;
  }

  // recursively fetching indefinitely until doctors is returned
  _fetchSingleAppointment(int id, BaseModel model){

    return _api.fetchSingleAppointment(

        id: id,

        onSuccess: (result){

          if(!model.mounted){
            return;
          }

          Appointment m = Appointment.fromJson(result);
          int? i = appointments.indexWhere((element) => element.id == m.id);


          if(i != -1){
            appointments[i] = appointment = m;
          }else {
            appointments.add(m);
            appointment = appointments.last;
          }

        },
        onError: (e)async{

          if(!model.mounted){
            return false;
          }
          await Future.delayed(Duration(seconds: 2));
          await _fetchSingleAppointment(id, model);
        }
    );
  }


}