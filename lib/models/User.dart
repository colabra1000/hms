import 'package:hms/models/Appointment.dart';
import 'package:hms/models/Notification.dart';

class User{

  int? id;
  int? myPlan;
  String? firstName;
  String? lastName;
  List? appointments;
  List? notifications;

  int? country;
  String? dateOfBirth;
  String? email;
  int? gender;
  int? bloodGroup;
  int? genotype;

  User.fromJson(Map json){

    id = json["id"];
    myPlan = json["myPlan"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    appointments = Appointment().toList(json["appointments"]);
    notifications = Notification().toList(json["notifications"]);

    country = json["country"];
    dateOfBirth = json["dateOfBirth"];
    email = json["email"];
    gender = json["gender"];
    bloodGroup = json["bloodGroup"];
    genotype = json["genotype"];


  }





}