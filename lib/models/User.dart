import 'package:hms/models/Appointment.dart';

class User{

  int? id;
  String? firstName;
  String? lastName;
  List? appointments;

  User.fromJson(Map json){

    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    appointments = Appointment().toList(json["appointments"]);

  }



}