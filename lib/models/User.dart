import 'package:hms/models/Appointment.dart';

class User{

  String? firstName;
  String? lastName;
  late List appointments;

  User.fromJson(Map json){

    firstName = json["firstName"];
    lastName = json["lastName"];
    appointments = Appointment().toList(json["appointments"]);

  }



}