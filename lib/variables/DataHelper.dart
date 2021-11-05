
import 'package:hms/models/Doctor.dart';

class DataHelper{

  static String getDoctorName(int? i, List doctors){

    if(i == null) return "";

    Map? json = doctors.firstWhere((element) => element["id"] == i, orElse: ()=> null);
    Doctor doctor = Doctor.fromJson(json ?? {});
    String firstName = doctor.firstName ?? "";
    String lastName = doctor.lastName ?? "";

    return "$firstName $lastName";

  }



}