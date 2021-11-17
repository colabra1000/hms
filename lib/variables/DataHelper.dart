
import 'package:hms/models/Organisation.dart';
import 'package:hms/models/Specialization.dart';

class DataHelper{

  static String getOrganisationName(int? id, List organisations){

    if(id == null) return "";

    Map? json = organisations.firstWhere((element) => element["id"] == id, orElse: ()=> null);
    Organisation organisation = Organisation.fromJson(json ?? {});
    return organisation.name ?? "";
  }


  static String getSpecialization(int? id, List specializations){

    if(id == null) return "";
    Map? json = specializations.firstWhere((element) => element["id"] == id, orElse: ()=> null);
    Specialization specialization = Specialization.fromJson(json ?? {});
    return specialization.name ?? "";

  }


  static String getMessageReadStatus(int? id, List readStatus){

    if(id == null) return "";
    Map? json = readStatus.firstWhere((element) => element["id"] == id, orElse: ()=> null);
    return json?["value"] ?? "";

  }

  static String getNotificationType(int? id, List notificationTypes) {
    if(id == null) return "";
    Map? json = notificationTypes.firstWhere((element) => element["id"] == id, orElse: ()=> null);
    return json?["value"] ?? "";
  }

  static List getUserAppointments(int id, List appointments) {

    return appointments.where((element) => element["userId"] == id).toList();

  }

  static getAppointmentStatus(int? id, appointmentStatus) {

    if(id == null) return "";
    Map? json = appointmentStatus.firstWhere((element) => element["id"] == id, orElse: ()=> null);
    return json?["value"] ?? "";

  }

}