library data;

import 'package:hms/data/DataHelper.dart';


part 'repo/Organisations.dart';
part 'repo/Messages.dart';
part 'repo/Specialization.dart';
part 'repo/Notifications.dart';
part 'repo/Appointments.dart';



class GlobalData{


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
    "myPlan" : 1,
    "appointments" : DataHelper.getUserAppointments(0, _appointments),
    "notifications" : DataHelper.getNotifications(0, notifications),
  };


}