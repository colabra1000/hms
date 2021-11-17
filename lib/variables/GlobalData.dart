library data;

import 'package:hms/models/Appointment.dart';
import 'package:hms/variables/DataHelper.dart';


part 'data/Organisations.dart';
part 'data/Messages.dart';
part 'data/Specialization.dart';
part 'data/Notifications.dart';
part 'data/Appointments.dart';



class GlobalData{

  GlobalData(){
  }

  static List specialization = _specialization;

  static List organisations = _organisations;

  static List messages = _messages;

  static List get notifications{

    _notifications.removeWhere((element) {
      return element == null;
    });


    return _notifications;

  }

  static List appointments = _appointments;


  static List readStatus = [
    {"id": 0, "value": "UNSEEN"},
    {"id": 1, "value": "UNREAD"},
    {"id": 2, "value": "READ"},
  ];

  static List notificationTypes = [
    {"id" : 0, "value" : "NEW_MESSAGE"},
    {"id" : 1, "value" : "APPOINTMENT_BOOKED"},
    {"id" : 2, "value" : "APPOINTMENT_CANCELLED"},
  ];

  static List appointmentStatus = [
    {"id" : 0, "value" : "PENDING"},
    {"id" : 1, "value" : "ACCEPTED"},
    {"id" : 2, "value" : "CANCELLED"},
  ];

  static List genders = [
    "Male", "Female"
  ];


  static Map user = {
    "id" : 0,
    "firstName" : "Aitem",
    "lastName" : "Quancy",
    "appointments" : DataHelper.getUserAppointments(0, _appointments),
  };


}