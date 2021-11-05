library data;

import 'package:hms/models/Doctor.dart';
import 'package:hms/variables/DataHelper.dart';
part 'data/DoctorsData.dart';


class GlobalData{

  static List doctors = _doctorsData;

  static List gender = [
    "Male", "Female"
  ];


  static Map user = {
    "firstName" : "Aitem",
    "lastName" : "Quancy",
    "appointments" : [
      {
        "doctorId" : 0,
        "doctorName" : DataHelper.getDoctorName(0, doctors),
        "time" : "12:00",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 1,
        "doctorName" : DataHelper.getDoctorName(1, doctors),
        "time" : "12:00",
        "accepted" : false,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 0,
        "doctorName" : DataHelper.getDoctorName(0, doctors),
        "time" : "12:00",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 2,
        "doctorName" : DataHelper.getDoctorName(2, doctors),
        "time" : "12:00",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 0,
        "doctorName" : DataHelper.getDoctorName(0, doctors),
        "time" : "12:00",
        "accepted" : false,
        "message" : "lorem ipsum"
      }

    ],


  };


}