import 'package:hms/models/Appointment.dart';
import 'package:hms/models/Notification.dart';

class User{

  int? id;
  int? myPlan;
  String? firstName;
  String? lastName;
  List? appointments;
  List? notifications;

  User.fromJson(Map json){

    id = json["id"];
    myPlan = json["myPlan"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    appointments = Appointment().toList(json["appointments"]);
    notifications = Notification().toList(json["notifications"]);

  }





}